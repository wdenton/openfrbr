xml.instruct!
xml.rdf(:RDF,
	"xmlns:frbr" => "http://vocab.org/frbr/core#",
	"xmlns:dc"   => "http://purl.org/dc/terms/",
        "xmlns:foaf" => "http://xmlns.com/foaf/0.1/",
        "xmlns:rdf"  => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "xmlns:rdfs" => "http://www.w3.org/2000/01/rdf-schema#") do

  xml.frbr(:Expression, "rdf:about" => url_for(@expression)) do
    xml.rdf(:type, "rdf:resource" => "http://vocab.org/core/frbr/term-Expression")
    xml.dc(:title, @expression.title)
    xml.dc(:language, @expression.language)
    xml.dc(:form, @expression.form)
    @expression.realizers.each do |realizer|
      xml.dc(:creator, realizer.name)
    end
    @expression.reifications.each do |reification|
      xml.frbr(:realizationOf, url_for(reification.work))
    end
    @expression.manifestations.each do |manifestation|
      xml.frbr(:embodiment, url_for(manifestation))
    end
  end

end
