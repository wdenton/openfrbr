#!/usr/bin/ruby -w

require 'net/http'
#require 'xmlsimple'
require 'rubygems'
require 'json'

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

OLUrl = "http://openlibrary.org/query.json?type=/type/edition&*=&"

if isbn.length == 10
  OLUrl << "isbn_10=" + isbn
elsif isbn.length == 13
  OLUrl << "isbn_13=" + isbn
end

puts OLUrl

begin
  # response = Net::HTTP.get_response(URI.parse(OLUrl)).body
  response = File.new("ol-azkaban.json").read
  # Querying for an ISBN should give us just one result so we
  # can use the first result in the array response and ignore
  # anything else. (Or so I hope.)
  result = JSON.parse(response)[0]
  if result.nil?
    raise "Unknown to Open Library"
  end
rescue Exception => error
  puts "Got an error: #{error}"
  exit
end


puts "title: " + result['title']
result['publishers'].each do |p|
  puts "  publisher: " + p
end
puts "       date: " + result['publish_date']
puts "    edition: " + result['edition_name']
result['subjects'].each do |p|
  puts "    subject: " + p
end
result['languages'].each do |p|
  puts "   language: " + p['key'].split(/\//)[2] # /l/eng => eng
end
result['works'].each do |p|
  puts "       work: " + p['key'].split(/\//)[2] # /works/foo => foo
end

# puts result['subject_place'].to_s


