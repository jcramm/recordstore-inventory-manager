require './lib/models/album'
require './lib/models/artist'
require 'csv'


module Imports
  class CsvSerializer

    HEADER = %w[artist_name title format year]

    def serialize(data)
      objs = []
      CSV.parse(data, headers: HEADER) do |row|
        hsh = row.to_h
        artist = Models::Artist.new('name' => hsh['artist_name'])
        objs.push(artist)
        hsh['artist_id'] = artist.generate_id
        objs.push(Models::Album.new(hsh))
      end
      objs
    end
  end
end