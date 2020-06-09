require './lib/models/album'
require './lib/models/artist'
require './lib/models/inventory_item'
require './lib/models/base'
require 'csv'


module Imports
  class CsvSerializer

    HEADER = %w[artist_name title format year]

    def serialize(data)
      objs = []
      CSV.parse(data, headers: HEADER) do |row|
        hsh = row.to_h
        hsh.transform_values! {|v| Models::Base.scrub_string(v)}
        artist = Models::Artist.new('name' => hsh['artist_name'])
        objs.push(artist)
        hsh['artist_id'] = artist.generate_id
        album = Models::Album.new(hsh)
        objs.push(Models::Album.new(hsh))
        hsh['album_id'] = album.generate_id
        # TODO
        # replace this with a find
        inventory_item = Models::InventoryItem.new(hsh)
        inventory_item = Models::InventoryItem.where(id: inventory_item.generate_id).first || inventory_item
        inventory_item.add_inventory
        objs.push(inventory_item)
      end
      objs
    end
  end
end