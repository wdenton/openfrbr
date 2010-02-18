#!/usr/bin/ruby -w

# Find Library Thing's "common knowledge" for a given work.
#
# Documentation:
# http://www.librarything.com/services/librarything.ck.getwork.php
#
# You will need a LibraryThing API key to use this.
#
# Example from documentation:
# http://www.librarything.com/services/rest/1.0/?method=librarything.ck.getwork&id=113&apikey=d231aa37c9b4f5d304a60a3d0ad1dad4

# Parameters you can pass in:
# id (optional): The LibraryThing work ID.
# isbn (optional): An ISBN for any edition of the work
# lccn (optional): An LCCN number for an edition of the work
# oclc (optional): The OCLC number for the work
# name (optional): The name of the work

require 'net/http'
require 'rexml/document'
include REXML

if ARGV.length < 2
  puts "Please specify a work ID and LibraryThing API key"
  exit 0
end

# TODO Make it accept ISBNs or other IDs, as user wishes.
# But I think for what I need, work IDs are what I need.
workId = ARGV[0]
apiKey = ARGV[1]

ltWorkUrl = "http://www.librarything.com/services/rest/1.0/?method=librarything.ck.getwork&id=::ID::&apikey=::APIKEY::"

ltWorkURL = ltWorkUrl.gsub!(/::ID::/, workId)
ltWorkURL = ltWorkUrl.gsub!(/::APIKEY::/, apiKey)

puts ltWorkURL

begin
  xml_data = Net::HTTP.get_response(URI.parse(ltWorkUrl)).body
  # puts xml_data
  doc = REXML::Document.new(xml_data)
rescue Exception => error
  puts "Got an error: #{error}"
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
# puts doc.elements["response/ltml/item/author"].text

canonicalTitle = doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='21']/versionList/version/factList/fact"].text

fields = {"2" => "Places",
  "3" => "People",
  "34" => "Events" }

fields.each {|number, entity|
  puts entity
  doc.each_element("response/ltml/item/commonknowledge/fieldList/field[@type='#{number}']/versionList/version/factList/fact") do |e|
    puts "  " + e.text
  end
}

exit

# puts fields

# response/ltml/item/commonknowledge/fieldlist/field type="34"


