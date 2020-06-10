#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/views/album/show'
require './lib/search'

attribute = ARGV[0]
value = ARGV[1]
albums = Search.search(attribute, value)
albums.each do |album|
  puts Views::Album::Show.new(album).render
end
