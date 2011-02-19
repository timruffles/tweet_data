require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require
require 'rdf'
require 'linkeddata'
require 'pp'

# graph = RDF::Graph.load("http://dbpedia.org/resource/Category:Premier_League_clubs")
graph = RDF::Graph.load("http://dbpedia.org/page/Arsenal_F.C.")

puts graph.size

query = RDF::Query.new({
  :club => {
    RDF::URI('http://dbpedia.org/property/body') => :body,
    RDF::URI('http://dbpedia.org/property/leftarm') => :leftarm,
    RDF::URI('http://dbpedia.org/property/rightarm') => :rightarm,
    RDF::URI('http://dbpedia.org/property/shorts') => :shorts,
    RDF::URI('http://dbpedia.org/property/socks') => :socks
  }
})

results = query.execute(graph)
puts results.length
results.each do |club|
  puts club[:body]
end

