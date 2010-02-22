#!/usr/bin/ruby -w

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

  # First, do we know this work from the LibraryThing ID?

  knownWork = Work.find_by_libraryThingId(ltWorkId)
  if ! knownWork.nil?
    puts "Known already by LT ID, going no further"
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

  # TODO Find out why only one author is ever listed
  # Eg Good Omens, 5794, lists Neil Gaiman but not Terry Pratchett
  doc.each_element("response/ltml/item/author") do |a|
    puts "Author: " + a.text
  end

  canonicalTitle = ''
  unless doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='21']/versionList/version/factList/fact"].nil?
    canonicalTitle = doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='21']/versionList/version/factList/fact"].text
  end

  originalPublicationDate = ''
  unless doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='16']/versionList/version/factList/fact"].nil?
    originalPublicationDate = doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='16']/versionList/version/factList/fact"].text
  end

  puts "  Title: " + title
  puts "  Canonical title: " + canonicalTitle
  puts "  Original publication date: " + originalPublicationDate

  title = canonicalTitle if canonicalTitle.length > 0

  puts "Does this work exist?  If not, create it"

  knownWork = Work.find(:first,
                          :conditions => {
                            :title => title,
                            :date => originalPublicationDate
                          })

  unless knownWork.nil?
    puts "Work is known: #{knownWork.id}"
    return knownWork.id
  end

  puts "This work is not known, so we must create it"

  fields = {
    "2"  => "Place",
    "3"  => "Person",
    "34" => "Event"
  }

  # TODO Use series information to connect related works
  # "Harry Potter (4)" is easy enough to grok.

  fields.each {|number, entity|
    # puts entity
    doc.each_element("response/ltml/item/commonknowledge/fieldList/field[@type='#{number}']/versionList/version/factList/fact") do |e|
      # puts "  " + e.text
    end
  }

  puts " -> creating Work with #{title} and #{originalPublicationDate}"

  begin
    w = Work.new(:title => title,
                 :date => originalPublicationDate,
                 :libraryThingId => ltWorkId)
    w.save
  rescue Exception => error
    STDERR.puts "Error saving Work #{title}: #{error}"
  end
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

manifestationToWork = {}

doc.root.each_element('/rsp/isbn') do |i|

  isbn = i.text
  xISBNs << isbn

  puts "-----" + isbn

  # While we're doing our pass through the ISBNs, let's grab
  # whatever Work information we can from LibraryThing's What Work
  # service.

  ltWorkId = whatWork(isbn)

  if ltWorkId.nil?
    puts "  ** There is no LT work for this ISBN"
    next
  end

  puts "-> find_or_create_work_from_common_knowledge(#{ltWorkId}, #{ltApiKey}"
  workid = find_or_create_work_from_common_knowledge(ltWorkId, ltApiKey)

  # Required by the Manifestation model.
  title = i.attributes["title"]
  # Also identifier (= isbn)

  # Not required.
  form = i.attributes["form"]
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
  # # puts language
  # # puts originalLanguage
  # puts "Edition: #{edition}"
  # puts "Form of carrier: #{form_of_carrier}"

  begin
    puts " Saving manifestation"
    m = Manifestation.new(:title => title,
                          #:publisher => publisher,
                          #:publication_date => year,
                          :edition => edition,
                          :identifier => isbn,
                          :form_of_carrier => form_of_carrier
                          )
    m.save
    puts "--> M: #{m.id}, W: #{workid}"
    manifestationToWork[m.id] = workid

  rescue Exception => e
    puts "There was an error: #{e}"
  end

  # Now we have a bunch of Manifestations entities stored away.
  # We have a bunch of Works stored away.
  # We have them connected by manifestationsToLTWorks hash.
  # Next, distinguish Expressions and make all the connections.

end

# Useful later? The intersection of a set of sets (from Ruby Quicktips)
# a = [[1,2,3],[2,3,4],[3,4,5]]
# a.inject(a.first) { |f,x| f = f | x } # => [1, 2, 3, 4, 5]

allISBNs = (thingISBNs + xISBNs).uniq

# Now we have a list of ISBNs of Manifestations of the same Work.
# (In theory.)
