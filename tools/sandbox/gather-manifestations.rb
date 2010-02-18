#!/usr/bin/ruby -w

# Use thingISBN and xISBN and put their answers together so as to get
# the most possible number of ISBNs of other manifestations of the
# same work as represented by the ISBN of one manifestation of said
# work.  Eliminate duplicates.
#
# TODO: Output non-ISBN ID numbers so that manifestations without
# ISBNs are also included.  When that is done then URIs like
# isbn:0670037796 or lccn:foo could be used.  Those would be ready to
# be pulled into a linked data set-up.

# Richard Pevear's new translation of THE THREE MUSKETEERS by Alexandre Dumas.
# isbn = '0670037796'

# Oxford Classics edition of same
# isbn = '0192835750'

# Anthony Powell, BOOKS DO FURNISH A ROOM, Fontana pb
isbn = '0006130879'

# Charles Willeford, THE BURNT ORANGE HERESY, Black Lizard
# isbn = '0887390250'

require 'net/http'
require 'rexml/document'
include REXML

# First, get data from thingISBN at LibraryThing

thingURL = "http://www.librarything.com/api/thingISBN/"

url = thingURL + isbn
# STDERR.puts url
xml_data = Net::HTTP.get_response(URI.parse(url)).body

doc = REXML::Document.new(xml_data)

thingISBNs = []

doc.root.each_element('/idlist/isbn') do |i|
  thingISBNs << i.text
  # STDERR.puts "thingISBN: #{i.text}"
end

# Next, get data from xISBN at OCLC

xISBNURL = "http://xisbn.worldcat.org/webservices/xid/isbn/"

# url = xISBNURL + isbn + "?method=getEditions&format=xml&fl=*"
url = xISBNURL + isbn + "?method=getEditions&format=xml"
# STDERR.puts url
xml_data = Net::HTTP.get_response(URI.parse(url)).body

doc = REXML::Document.new(xml_data)

xISBNs = []

doc.root.each_element('/rsp/isbn') do |i|
  xISBNs << i.text
  # STDERR.puts "    xISBN: #{i.text}"
end

# Useful later? The intersection of a set of sets (from Ruby Quicktips)
# a = [[1,2,3],[2,3,4],[3,4,5]]
# a.inject(a.first) { |f,x| f = f | x } # => [1, 2, 3, 4, 5]

allISBNs = (thingISBNs + xISBNs).uniq

xNotThing = []
thingNotX = []

allISBNs.sort.each do |isbn|
   xNotThing << isbn if xISBNs.include?(isbn) and not thingISBNs.include?(isbn)
   thingNotX << isbn if thingISBNs.include?(isbn) and not xISBNs.include?(isbn)
  puts isbn
end

# STDERR.puts " Known to thingISBN: #{thingISBNs.size} (#{thingNotX.size} of which not known to xISBN)"
# STDERR.puts " Known to     xISBN: #{xISBNs.size} (#{xNotThing.size} of which not known to thingISBN)"

# STDERR.puts "              Total: #{allISBNs.size}"

# Print ISBNs known to LibraryThing but not xISBN.
# thingNotX.sort.each do |isbn|
#   puts isbn
# end
