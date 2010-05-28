#!/usr/bin/ruby

# Test of http://rdf.rubyforge.org/

require 'rubygems'
require 'rdf_objects'
include RDFObject

resource = Resource.new('http://www.miskatonic.org/foaf.rdf')
resource.describe
# resource.skos
