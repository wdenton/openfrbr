#!/usr/bin/ruby -w

require 'rdf/redland'
require 'uri'

parser_name='raptor'

storage=Redland::TripleStore.new("hashes", "test", "new='yes',hash-type='memory',dir='.'")
raise "Failed to create RDF storage" if !storage

model=Redland::Model.new(storage)
if !model then
  raise "Failed to create RDF model"
end

# puts "model.size = #{model.size}"

parser=Redland::Parser.new(parser_name, "", nil)
if !parser then
  raise "Failed to create RDF parser"
end

falconURI = Redland::Uri.new("http://rdf.freebase.com/ns/en.the_maltese_falcon")
#parser.parse_into_model(model, falconURI)

gobletURI = Redland::Uri.new("http://rdf.freebase.com/ns/en.harry_potter_and_the_goblet_of_fire")
parser.parse_into_model(model, gobletURI)

puts "model.size = #{model.size}"

model.dump_model

nameURI = Redland::Uri.new("http://rdf.freebase.com/ns/type.object.name")

puts "--->"
puts model.object(gobletURI, nameURI).value

exit


languageUri = Redland::Uri.new("http://rdf.freebase.com/ns/book.written_work.original_language")

# workLanguageUri = model.object(gobletURI, languageUri).uri || "Not known"

parser.parse_into_model(model,Redland::Uri.new(workLanguageUri))

puts "model.size = #{model.size}"

isoLanguageCodeUri = Redland::Uri.new("http://rdf.freebase.com/ns/language.human_language.iso_639_3_code")

puts model.object(workLanguageUri, isoLanguageCodeUri) || "Not known"

# model.dump_model



