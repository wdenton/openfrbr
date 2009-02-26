xml.instruct!
xml.rdf(:RDF,
	"xmlns:frbr" => "http://vocab.org/frbr/core#",
	"xmlns:dc"   => "http://purl.org/dc/terms/",
        "xmlns:foaf" => "http://xmlns.com/foaf/0.1/",
        "xmlns:rdf"  => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "xmlns:rdfs" => "http://www.w3.org/2000/01/rdf-schema#") do

  xml.frbr(:Manifestation, "rdf:about" => url_for(@manifestation)) do
    xml.rdf(:type, "rdf:resource" => "http://vocab.org/core/frbr/term-Manifestation")
    xml.dc(:title, @manifestation.title)
    xml.dc(:creator, @manifestation.statement_of_responsibility)
    xml.dc(:publisher, @manifestation.publisher)
    xml.dc(:date, @manifestation.publication_date)
    xml.dc(:identifier, @manifestation.identifier)
    xml.dc(:format, @manifestation.form_of_carrier)
    @manifestation.producers.each do |producer|
      xml.dc(:creator, producer.name)
    end
    xml.frbr(:embodimentOf, url_for(@manifestation.expression))
    @manifestation.items.each do |item|
      xml.frbr(:exemplar, url_for(item))
    end
  end

end
