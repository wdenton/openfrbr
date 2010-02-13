#!/usr/bin/ruby -w

#require 'rubygems'
#require 'xisbn'
#include XISBN

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

things = thing_isbn(isbn)

# puts things.size
puts things.sort


