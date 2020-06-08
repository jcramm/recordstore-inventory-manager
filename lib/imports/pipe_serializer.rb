require './lib/models/album'
require './lib/models/artist'
require 'csv'

module Imports
  class PipeSerializer

    HEADER = %w[quantity format year artist_name title]

    def serialize(data)
      objs = []
      CSV.parse(data, {headers: HEADER, :col_sep => "|"}) do |row|
        hsh = row.to_h
        artist = Models::Artist.new('name' => hsh['artist_name'])
        objs.push(artist)
        hsh['artist_id'] = artist.generate_id
        (0..hsh['quantity'].to_i).to_a.each {|i| objs.push(Models::Album.new(hsh))}
      end
      objs
    end
  end
end