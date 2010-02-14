#!/usr/local/bin/ruby

# Use thingISBN and xISBN and put their answers together so as to get
# the most possible number of ISBNs of other manifestations of the same
# work as represented by the ISBN of one manifestation of said work.
# Eliminate duplicates.

# Change the ISBN to anything you want.  This one is for 

# Richard Pevear's new translation of THE THREE MUSKETEERS by Alexandre Dumas.
# isbn = '0670037796'

# Oxford Classics edition that WorldCat has only one other manifestation for
# isbn = '0192835750'

# Anthony Powell, BOOKS DO FURNISH A ROOM, Fontana pb
# isbn = '0006130879'

# Charles Willeford, THE BURNT ORANGE HERESY, Black Lizard
isbn = '0887390250'

require 'net/http'

require 'rubygems'
require 'xmlsimple'

puts "Finding manifestations of #{isbn} ..."

# First, get data from thingISBN at LibraryThing

thingURL = "http://www.librarything.com/api/thingISBN/"

url = thingURL + isbn
puts url
xml_data = Net::HTTP.get_response(URI.parse(url)).body

data = XmlSimple.xml_in(xml_data)

thingISBNs = []

data['isbn'].each do |i|
  thingISBNs << i
  # puts "thingISBN: #{i}"
end

# Next, get data from xISBN at OCLC

xISBNURL = "http://xisbn.worldcat.org/webservices/xid/isbn/"

# url = xISBNURL + isbn + "?method=getEditions&format=xml&fl=*"
url = xISBNURL + isbn + "?method=getEditions&format=xml"
puts url
xml_data = Net::HTTP.get_response(URI.parse(url)).body

data = XmlSimple.xml_in(xml_data)

xISBNs = []

data['isbn'].each do |i|
  xISBNs << i
  # puts "xISBN: #{i}"
end

allISBNs = (thingISBNs + xISBNs).uniq

xNotThing = []
thingNotX = []

allISBNs.each do |isbn|
   xNotThing << isbn if xISBNs.include?(isbn) and not thingISBNs.include?(isbn)
   thingNotX << isbn if thingISBNs.include?(isbn) and not xISBNs.include?(isbn)
end

puts " Known to thingISBN: #{thingISBNs.size} (#{thingNotX.size} of which not known to xISBN)"
puts " Known to     xISBN: #{xISBNs.size} (#{xNotThing.size} of which not known to thingISBN)"

puts "              Total: #{allISBNs.size}"

# Print ISBNs known to LibraryThing but not xISBN.
# thingNotX.sort.each do |isbn|
#   puts isbn
# end
