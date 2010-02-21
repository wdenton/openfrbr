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
#   id: LibraryThing work ID
# isbn: ISBN for any edition of the work
# lccn: LCCN number for an edition of the work
# oclc: OCLC number for the work
# name: Name of the work

require 'net/http'
require 'rexml/document'
include REXML

if ARGV.length < 2
  puts "Please specify a work ID and LibraryThing API key"
  exit 0
end

# TODO Make it accept ISBNs or other IDs, as user wishes.
# But I think for what I need, work IDs are fine for now.
workId = ARGV[0]
apiKey = ARGV[1]

# Interlude to get the title of the work.  The canonicalTitle field in
# the Common Knowledge is probably better, but it's not always there.
# I think it's entered by LibraryThing users, so it can be relied on
# to be unencumbered knowledge.  The title of the work might be drawn
# from Amazon, Tim Spalding said, so they couldn't share it.  "Find it
# yourself," he said.  So we will.

ltWorkUrl = "http://www.librarything.com/work/" + workId
workPageHtml = Net::HTTP.get_response(URI.parse(ltWorkUrl)).body

# Now back to gathering the Common Knowledge about the work.

ltCkWorkUrl = "http://www.librarything.com/services/rest/1.0/?method=librarything.ck.getwork&id=::ID::&apikey=::APIKEY::"

ltCkWorkURL = ltCkWorkUrl.gsub!(/::ID::/, workId)
ltCkWorkURL = ltCkWorkUrl.gsub!(/::APIKEY::/, apiKey)

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
# puts doc.elements["response/ltml/item/author"].text

canonicalTitle = doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='21']/versionList/version/factList/fact"].text

originalPublicationDate = doc.elements["response/ltml/item/commonknowledge/fieldList/field[@type='16']/versionList/version/factList/fact"].text

puts "Canonical title: " + canonicalTitle
puts "Original publication date: " + originalPublicationDate

fields = {
  "2"  => "Place",
  "3"  => "Person",
  "34" => "Event"
}

# TODO Use series information to connect related works
# "Harry Potter (4)" is easy enough to grok.

fields.each {|number, entity|
  puts entity
  doc.each_element("response/ltml/item/commonknowledge/fieldList/field[@type='#{number}']/versionList/version/factList/fact") do |e|
    puts "  " + e.text
  end
}

