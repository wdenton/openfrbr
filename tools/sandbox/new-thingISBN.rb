#!/usr/bin/ruby -w

require 'net/http'
require 'xmlsimple'

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

thingISBNUrl = "http://www.librarything.com/api/thingISBN/::ISBN::"
begin
  thingUrl = thingISBNUrl.gsub(/::ISBN::/, isbn)
  puts thingUrl
  xml_data = Net::HTTP.get_response(URI.parse(thingUrl)).body

  isbns = []
  doc = REXML::Document.new(xml_data)
  doc.elements.each('idlist/isbn') {|e| isbns << e.text}

rescue
end

puts isbns

