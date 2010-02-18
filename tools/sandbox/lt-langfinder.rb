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

thingLangUrl = "http://www.librarything.com/api/thingLang.php?isbn=" + isbn

begin
  puts Net::HTTP.get_response(URI.parse(thingLangUrl)).body
rescue Exception => error
  puts "Got an error: #{error}"
end
