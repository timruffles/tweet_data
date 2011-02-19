require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require
require 'rdf'
require 'linkeddata'
require 'pp'
require 'yaml'

clubs = {}
YAML.load_file('output/clubs.yaml').each_pair do |literal, data|
  clubs[literal.to_s] = Hash[data.map {|k,v| [k.to_s,v.to_s] }]
end
File.open('output/literals.yaml','w+') << clubs.to_yaml