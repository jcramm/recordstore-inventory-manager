#!/usr/bin/env ruby
require './lib/views/album'
require './lib/search'

attribute = ARGV[0]
value = ARGV[1]
albums = Search.search(attribute => value)
albums.each do |album|
  puts Views::Album.new(album).render
end