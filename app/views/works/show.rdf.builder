xml.instruct!
xml.rdf(:RDF,
	"xmlns:frbr" => "http://vocab.org/frbr/core#",
	"xmlns:dc"   => "http://purl.org/dc/terms/",
        "xmlns:foaf" => "http://xmlns.com/foaf/0.1/",
        "xmlns:rdf"  => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "xmlns:rdfs" => "http://www.w3.org/2000/01/rdf-schema#") do

  xml.frbr(:Work, "rdf:about" => url_for(@work)) do
    xml.rdf(:type, "rdf:resource" => "http://vocab.org/core/frbr/term-Work")
    xml.dc(:title, @work.title)
    @work.creators.each do |creator|
      xml.dc(:creator, creator.name)
    xml.dc(:form, @work.form)
    xml.dc(:date, @work.date)
    end
    @work.reifications.each do |reification|
      xml.frbr(:realization, url_for(reification.expression))
    end
  end

end
