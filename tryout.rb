require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require
require 'rdf'
require 'linkeddata'
require 'pp'
require 'yaml'

clubs = {}
graph = RDF::Graph.load("http://dbpedia.org/resource/Category:Premier_League_clubs")
club_query = RDF::Query.new({
  :club => {
    RDF::URI('http://purl.org/dc/terms/subject') => :club_url
  }
})
club_query.execute(graph).each do |club|
  graph = RDF::Graph.load(club.club.to_str)
  puts graph.size
  query = RDF::Query.new({
    :club => {
      RDF::URI('http://dbpedia.org/property/clubname') => :clubname,
      RDF::URI('http://dbpedia.org/property/body') => :body,
      RDF::URI('http://dbpedia.org/property/leftarm') => :leftarm,
      RDF::URI('http://dbpedia.org/property/rightarm') => :rightarm,
      RDF::URI('http://dbpedia.org/property/shorts') => :shorts,
      RDF::URI('http://dbpedia.org/property/socks') => :socks,
      RDF::FOAF.nick => :nickname,
      RDF::FOAF.homepage => :homepage,
      RDF::URI('http://dbpedia.org/property/founded') => :founded
    }
  })
  results = query.execute(graph)
  puts results.length
  results.each do |club|
    clubs[club.clubname] = club.to_hash
  end
end
File.open('output/clubs.yaml','w+') << clubs.to_yaml