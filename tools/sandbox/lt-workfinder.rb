#!/usr/bin/ruby -w

# Given an ISBN, find the corresponding LibraryThing work ID.
#
# Documentation:
# http://www.librarything.com/thingology/2009/03/new-api-what-work.php
#
# Does not require an API key.
#
# It's also possible to give LibraryThing a title (plus optional
# author) and have it guess.  As Tim Spalding says, "It's very
# forgiving about punctuation, capitalization and so forth. It doesn't
# make wild guesses, but it makes sensible ones."

require 'net/http'
require 'rexml/document'
include REXML

require 'isbncheck'

if ARGV.length == 0
  puts "Please specify an ISBN"
  exit 0
end

isbn = ARGV[0]

unless is_valid_isbn(isbn)
  puts "Not a valid ISBN"
  exit 0
end

thingWorkUrl = "http://www.librarything.com/api/whatwork.php?isbn=" + isbn

begin
  xml_data = Net::HTTP.get_response(URI.parse(thingWorkUrl)).body
  doc = REXML::Document.new(xml_data)
  puts doc.elements["titleauthor/work"].text
rescue Exception => error
  puts "Got an error: #{error}"
end
