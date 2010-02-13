#!/usr/local/bin/ruby -w

require 'net/http'

require 'rubygems'
require 'xisbn'
include XISBN
require 'xmlsimple'

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

def my_xisbn (isbn)
  xISBNURL = "http://xisbn.worldcat.org/webservices/xid/isbn/::ISBN::?method=getEditions&format=xml&fl=*"
  begin
    xurl = xISBNURL.gsub(/::ISBN::/, isbn)
    xml_data = Net::HTTP.get_response(URI.parse(xurl)).body
    data = XmlSimple.xml_in(xml_data, { 'ForceContent' => true })
    isbns = []
#     if data['isbn'].size == 1
#       if data['isbn'][0]['title'].nil?
#         # It's unknown
#       else
#         isbns << data['isbn'][0]['content']
#       end
#     else
#       data['isbn'].each do |j|
#         isbns << j['content']
#       end
#     end
    if (data['isbn'].size == 1) and (data['isbn'][0]['title'].nil?)
        # It's unknown
    else 
      data['isbn'].each do |j|
        isbns << j['content']
      end
    end
  rescue
  end
  return isbns
end

xs = my_xisbn(isbn)

# puts xs.size
puts xs.sort
