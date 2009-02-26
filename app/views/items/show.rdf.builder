xml.instruct!
xml.rdf(:RDF,
	"xmlns:frbr" => "http://vocab.org/frbr/core#",
	"xmlns:dc"   => "http://purl.org/dc/terms/",
        "xmlns:foaf" => "http://xmlns.com/foaf/0.1/",
        "xmlns:rdf"  => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "xmlns:rdfs" => "http://www.w3.org/2000/01/rdf-schema#") do

  xml.frbr(:Item, "rdf:about" => url_for(@item)) do
    xml.rdf(:type, "rdf:resource" => "http://vocab.org/core/frbr/term-Item")
    @item.owners.each do |owner|
      xml.frbr(:owner, owner.name)
    end
    xml.frbr(:exemplarOf, url_for(@item.manifestation))
    xml.dc(:provenance, @item.provenance)
    xml.dc(:identifier, @item.identifier)
    xml.dc(:subject, @item.call_number)
  end

end
