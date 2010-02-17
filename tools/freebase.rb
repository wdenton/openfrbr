#!/usr/bin/ruby -w

require 'open-uri'

require 'rubygems'
require 'rdf_objects'
include RDFObject

Curie.add_prefixes! :cc=>'http://creativecommons.org/ns#'
Curie.add_prefixes! :owl=>'http://www.w3.org/2002/07/owl#'
Curie.add_prefixes! :fb=>'http://rdf.freebase.com/ns/'
Curie.add_prefixes! :rdf=>'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
Curie.add_prefixes! :xhtml=>'http://www.w3.org/1999/xhtml/vocab#'

#philosopherURL = 'http://rdf.freebase.com/rdf/guid.9202a8c04000641f800000000005ff51'

#collection = Collection.new

#resource = Resource.new("http://rdf.freebase.com/rdf/guid.9202a8c04000641f800000000005ff51")

#puts resource

# resource = Resource.new("http://dbpedia.org/data/Harry_Potter_and_the_Philosopher%27s_Stone.rdf")

#resource = Resource.new("http://rdf.freebase.com/ns/en.the_maltese_falcon")

#puts resource

# resource = Resource.new('http://id.loc.gov/authorities/sh2002000569#concept')

# resource = Parser.parse(open('philosopher.rdf').read)

#puts resource.describe
#puts resource.skos

collection = Parser.parse(open('http://rdf.freebase.com/rdf/en.the_maltese_falcon'))

collection.each_pair { |key, value| 
  puts key
  puts value
#  puts value.describe
}
#  puts "----------"
  # puts ""
#end

rs = collection.find_by_predicate("http://rdf.freebase.com/ns/book.book")

puts rs

#r1 = collection.find_or_create("http://rdf.freebase.com/ns/fictional_universe.work_of_fiction")

#r1.describe

#collection.each do |r|
#  puts r.class
#  puts r
#end
