#!/usr/bin/ruby -w

require 'net/http'
require 'rexml/document'
include REXML

require 'rubygems'

if ARGV.length == 0
  puts "Please specify an ISBN"
  exit 0
end

isbn = ARGV[0]
isbn = isbn.gsub(/[^0-9X]/,'')

if (! /\d{9}[0-9X]/.match(isbn))
  puts "This is not a valid ISBN" # Not a true validity check!
  exit 0
end

xISBNURL = "http://xisbn.worldcat.org/webservices/xid/isbn/::ISBN::?method=getEditions&format=xml&fl=*"
begin
  xurl = xISBNURL.gsub(/::ISBN::/, isbn)
#  xml_data = Net::HTTP.get_response(URI.parse(xurl)).body
  xml_data = File.open("/home/buff/src/openfrbr/tools/sandbox/goblet.xml").read
#  puts xml_data
rescue
end

doc = REXML::Document.new(xml_data)
doc.root.each_element('/rsp/isbn') do |i|
#  puts i
#  i.attributes.each do |a|
#    puts a[0]
#    puts a[1]
#  end
  title = i.attributes["title"]
  # puts "  City: " + i.attributes["city"]
  publisher = i.attributes["publisher"] || nil
  edition = i.attributes["ed"]
  form = i.attributes["form"]
  language = i.attributes["lang"]
  originalLang = i.attributes["originalLang"]


  puts title
  puts "  " + form
  m = Manifestation.new(:title => i.attributes["title"])

end



