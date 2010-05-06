#!/usr/bin/ruby -w

# Given an ISBN (and using a Library Thing API key), do the following:
# # - use thingISBN to get ISBNs of related Manifestations, from LibraryThing
# - use xISBN to get ISBNs of related Manifestations, from WorldCat
# - for each isbn
#   use LT's What Work to find out what this Manifestation's Work is
#   find the Work if it's known; create it if it's not (and Creator and Aboutnesses)
#   create Manifestation (and Producer)
#   create Expression by guesswork (and Reification and Embodiment)

require 'net/http'
require 'rexml/document'
include REXML

# require 'isbncheck'
def validate_isbn10(isbn)
  if (isbn || '').match(/^(?:\d[\ |-]?){9}[\d|X]$/)
    isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
    check_digit = isbn_values.pop # last digit is check digit
    check_digit = (check_digit == 'X') ? 10 : check_digit.to_i
    sum = 0
    isbn_values.each_with_index do |value, index|
      sum += (index + 1) * value.to_i
    end
    (sum % 11) == check_digit
  else
    false
  end
end

def validate_isbn13(isbn)
  if (isbn || '').match(/^(?:\d[\ |-]?){13}$/)
    isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
    check_digit = isbn_values.pop.to_i # last digit is check digit
    sum = 0
    isbn_values.each_with_index do |value, index|
      multiplier = (index % 2 == 0) ? 1 : 3
      sum += multiplier * value.to_i
    end
    (10 - (sum % 10)) == check_digit
   else
    false
  end
end

def is_valid_isbn(isbn)
  if (validate_isbn10(isbn) or validate_isbn13(isbn))
    return true
  else
    return false
  end
end

def whatWork(isbn)
  whatWorkUrl = "http://www.librarything.com/api/whatwork.php?isbn="

  begin
    what_work_xml = Net::HTTP.get_response(URI.parse(whatWorkUrl + isbn)).body
    what_work = REXML::Document.new(what_work_xml)
    if what_work.elements["titleauthor/work"].nil?
      return nil
    else
      return what_work.elements["titleauthor/work"].text
    end
  rescue Exception => error
    puts "Got an error: #{error}"
  end
end

def find_or_create_work_from_common_knowledge(ltWorkId, ltApiKey)

  # First, do we know this work already from the LibraryThing ID?

  knownWork = Work.find_by_libraryThing_id(ltWorkId)
  if ! knownWork.nil?
    puts "  Work is known: #{knownWork.id}"
    return knownWork.id
  end

  ltWorkUrl = "http://www.librarything.com/work/" + ltWorkId
  workPageHtml = Net::HTTP.get_response(URI.parse(ltWorkUrl)).body

  titleRegex = /<title>(.*) by.*<\/title>/xi
  titleRegex.match(workPageHtml)
  title = $1

  # Now back to gathering the Common Knowledge about the work.

  ltCkWorkUrl = "http://www.librarything.com/services/rest/1.0/?method=librarything.ck.getwork&id=::ID::&apikey=::APIKEY::"

  ltCkWorkURL = ltCkWorkUrl.gsub!(/::ID::/, ltWorkId)
  ltCkWorkURL = ltCkWorkUrl.gsub!(/::APIKEY::/, ltApiKey)

  # STDERR.puts ltCkWorkURL

  begin
    xml_data = Net::HTTP.get_response(URI.parse(ltCkWorkUrl)).body
    doc = REXML::Document.new(xml_data)
  rescue Exception => error
    STDERR.puts "Error: #{error}"
  end

  # Fields to use
  # Entities
  #   2 name="placesmentioned" displayName="Important places"
  #   3 name="characternames" displayName="Character names"
  #  34 name="events" displayName="Important events"
  # Attributes
  #  16 name="originalpublicationdate" displayName="Original publication date"
  #  21 name="canonicaltitle" displayName="Canonical Title"
  # Relations to other works
  #  23 name="series" displayName="Series"

  canonicalTitle = ''
  unless doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='21']/versionList/version/factList/fact"].nil?
    canonicalTitle = doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='21']/versionList/version/factList/fact"].text
  end

  originalPublicationDate = ''
  unless doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='16']/versionList/version/factList/fact"].nil?
    originalPublicationDate = doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='16']/versionList/version/factList/fact"].text
  end

  puts "  Work title: " + title
  puts "  Work canonical title: " + canonicalTitle
  puts "  Work original publication date: " + originalPublicationDate

  title = canonicalTitle if canonicalTitle.length > 0

  knownWork = Work.find(:first,
                          :conditions => {
                            :title => title,
                            :date => originalPublicationDate
                          })

  unless knownWork.nil?
    puts "Work is known: #{knownWork.id}"
    return knownWork.id
  end

  puts "  Creating Work with #{title} and #{originalPublicationDate}"

  begin
    w = Work.new(:title => title,
                 :date => originalPublicationDate,
                 :libraryThing_id => ltWorkId)
    w.save
  rescue Exception => error
    STDERR.puts "Error saving Work #{title}: #{error}"
  end

  # TODO Find out why only one author is ever listed
  # Eg Good Omens, 5794, lists Neil Gaiman but not Terry Pratchett
  doc.each_element("response/ltml/item/author") do |a|

    # Assume that the author is a Person, not a Corporate
    # Body or Family.
    creator_name = a.text || "[unknown]"

    per = Person.find_or_create_by_name(creator_name)
    puts "  Creator: #{creator_name}, Person: #{per.id}"

    cre = Creation.find(:first,
                       :conditions => {
                          :work_id => w.id,
                          :creator_id => per.id,
                          :creator_type => "Person"
                      })

    unless cre.nil?
      puts "  Creation is known: #{cre.id}"
    else
      cre = Creation.new(:work_id => w.id,
                         :creator_id => per.id,
                         :creator_type => "Person")
      cre.save
      puts "  Created Creation: #{cre.id}"
    end

  end

  fields = {
    "2"  => "Place",
    "3"  => "Person",
    "34" => "Event"
  }

  # TODO Use series information to connect related works
  # "Harry Potter (4)" is easy enough to grok.

  fields.each {|number, entity|
    doc.each_element("response/ltml/item/commonknowledge/fieldList/field[@type='#{number}']/versionList/version/factList/fact") do |e|
      if entity == "Person"
        ent = entity.constantize.find_or_create_by_name(e.text)
      else
        ent = entity.constantize.find_or_create_by_term(e.text)
      end
      puts "  #{entity} #{e.text}: #{ent.id}"

      abo = Aboutness.find(:first,
                           :conditions => {
                             :work_id => w.id,
                             :subject_id => ent.id,
                             :subject_type => entity
                      })

      unless abo.nil?
        puts "  Aboutmess is known: #{abo.id}"
      else
        abo = Aboutness.new(:work_id => w.id,
                            :subject_id => ent.id,
                            :subject_type => entity)
        abo.save
        puts "  Created Aboutness: #{abo.id}"
      end

    end
  }

  return w.id

end

if ARGV.length < 2
  puts "Please specify an ISBN and LibraryThing API key"
  exit 0
end

isbn = ARGV[0]
ltApiKey = ARGV[1]

unless is_valid_isbn(isbn)
  puts "Not a valid ISBN"
  exit 0
end

# Defaults to make this work.
defaultLanguage = "eng"
defaultOriginalLanguage = "eng"


# First, get data from thingISBN at LibraryThing

# thingURL = "http://www.librarything.com/api/thingISBN/"

# url = thingURL + isbn
# # STDERR.puts url
# xml_data = Net::HTTP.get_response(URI.parse(url)).body

# doc = REXML::Document.new(xml_data)

thingISBNs = []

# doc.root.each_element('/idlist/isbn') do |i|
#   thingISBNs << i.text
#   # STDERR.puts "thingISBN: #{i.text}"
# end

# Next, get data from xISBN at OCLC

xISBNURL = "http://xisbn.worldcat.org/webservices/xid/isbn/"

url = xISBNURL + isbn + "?method=getEditions&format=xml&fl=*"
# url = xISBNURL + isbn + "?method=getEditions&format=xml"
# STDERR.puts url
xml_data = Net::HTTP.get_response(URI.parse(url)).body

doc = REXML::Document.new(xml_data)

xISBNs = []

doc.root.each_element('/rsp/isbn') do |i|

  isbn = i.text
  xISBNs << isbn

  puts isbn

  # While we're doing our pass through the ISBNs, let's grab
  # whatever Work information we can from LibraryThing's What Work
  # service.

  ltWorkId = whatWork(isbn)

  if ltWorkId.nil?
    puts "  Skipping: There is no LibraryThing work for this ISBN"
    next
  else
    puts "  LibraryThing work #{ltWorkId}"
  end

  work_id = find_or_create_work_from_common_knowledge(ltWorkId, ltApiKey)

  # Required by the Manifestation model.
  title = i.attributes["title"]
  # Also identifier (= isbn)

  # Not required.
  publisher = i.attributes["publisher"]
  publication_place = i.attributes["city"]
  edition = i.attributes["ed"]
  language = i.attributes["lang"] || defaultLanguage
  originalLanguage = i.attributes["originalLang"] || defaultOriginalLanguage
  year = i.attributes["year"]
  statement_of_responsibility = i.attributes["author"] || nil # Not creator
  form_of_carrier = i.attributes["form"] || nil # AA, BA, etc. TODO Decode

  # puts "ISBN: #{isbn}"
  # puts "Title: #{title}"
  # puts "  Language: #{language}"
  # puts "  Original language: #{originalLanguage}"
  # puts "  Edition: #{edition}"
  # puts "  Form of carrier: #{form_of_carrier}"

  # TODO Find if this Manifestation exists already.
  # If so, use it.  If not, create it.

  begin
    m = Manifestation.new(:title => title,
                          :publisher => publisher,
                          :publication_date => year,
                          :edition => edition,
                          :identifier => isbn,
                          :form_of_carrier => form_of_carrier,
                          :statement_of_responsibility => statement_of_responsibility
                          )
    m.save
    puts "  Created Manifestation: #{m.id}"
  rescue Exception => e
    puts "There was an error: #{e}"
  end

  # Make the Manifestation's publisher a Corporate Body and create a
  # Production relation.

  # Assume that the author is a Person, not a Corporate Body or
  # Family.

  cor = CorporateBody.find_or_create_by_name(publisher)
  puts "  Creator: #{publisher}, Corporate Body: #{cor.id}"

  pro = Production.find(:first,
                        :conditions => {
                          :manifestation_id => m.id,
                          :producer_id => cor.id,
                          :producer_type => "CorporateBody"
                        })

  unless pro.nil?
    puts "  Production is known: #{pro.id}"
  else
    pro = Production.new(:manifestation_id => m.id,
                         :producer_id => cor.id,
                         :producer_type => "CorporateBody")
    pro.save
    puts "  Created Production: #{pro.id}"
  end

  # Now we have a bunch of Manifestations entities stored away.
  # We have a bunch of Works stored away.
  # Next, distinguish Expressions, create Expressions,
  # and create Reifications and Embodiments.

  # Expression-level details:
  #   originalLanguage
  #   edition (or not: "large print" is Manifestation-level)
  # For now, let's decide Expressions based on language and
  # originalLanguage.
  #
  # Fields we need to know for Expression:
  #   title
  #   language
  #   # form (I commented that out in the model)
  #
  # Expression.title = Manifestation.title
  # Expression.language = xISBN language

  e = Expression.find(:first,
                      :conditions => {
                        :title => title,
                        :language => language
                      })

  unless e.nil?
    puts "  Expression is known: #{e.id}"
  else
    e = Expression.new(:title => title,
                           :language => language)
    e.save
    puts "  Created Expression: #{e.id}"
  end

  # Create, if necessary, the Reification to connect the Work and
  # Expression

  r = Reification.find(:first,
                       :conditions => {
                         :work_id => work_id,
                         :expression_id => e.id
                      })

  unless r.nil?
    puts "  Reification is known: #{r.id}"
  else
    if language != originalLanguage
      relation = "translation from #{originalLanguage} to #{language}"
    else
      relation = "[unknown]"
    end
    new_r = Reification.new(:work_id => work_id,
                            :expression_id => e.id,
                            :relation => relation)
    new_r.save
    puts "  Created Reification: #{new_r.id}"
  end

  # Create, if necessary, the Embodiment to connect the Expression and
  # Manifestation

  b = Embodiment.find(:first,
                      :conditions => {
                        :expression_id => e.id,
                        :manifestation_id => m.id
                      })

  unless b.nil?
    puts "  Embodiment is known: #{b.id}"
  else
    new_b = Embodiment.new(:expression_id => e.id,
                           :manifestation_id => m.id,
                           :relation => edition)
    new_b.save
    puts "  Created Embodiment: #{new_b.id}"
  end

end

# Useful later? The intersection of a set of sets (from Ruby Quicktips)
# a = [[1,2,3],[2,3,4],[3,4,5]]
# a.inject(a.first) { |f,x| f = f | x } # => [1, 2, 3, 4, 5]

allISBNs = (thingISBNs + xISBNs).uniq

# Now we have a list of ISBNs of Manifestations of the same Work.
# (In theory.)
