require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require
require 'rdf'
require 'linkeddata'
require 'pp'

graph = RDF::Graph.load("http://dbpedia.org/resource/Elvis_Presley")
puts graph.size
query = RDF::Query.new({
  :jerson => {
    RDF::URI("http://dbpedia.org/ontology/birthDate") => :birthDate,
    RDF::URI("http://dbpedia.org/ontology/deathDate") => :deathDate
  }
})
results = query.execute(graph)
results.each do |club|
  puts club[:birthDate]
end

graph.query([nil, RDF::URI("http://dbpedia.org/ontology/deathDate")]).each_subject do |subject|
  puts subject.deathDate
end