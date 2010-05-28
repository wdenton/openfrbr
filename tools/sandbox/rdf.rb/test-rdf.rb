#!/usr/bin/ruby

# Test of http://rdf.rubyforge.org/

require 'rubygems'
require 'rdf'
require 'rdf/raptor' # So it can read .rdf files in XML
# require 'rdf/json'

RDF::Format.for(:rdfxml)
RDF::Reader.open("http://www.miskatonic.org/foaf.rdf") do |reader|
  reader.each_statement do |statement|
    puts statement.inspect
  end
end

#repository.each_graph do |graph|
#  puts graph.inspect
#end

