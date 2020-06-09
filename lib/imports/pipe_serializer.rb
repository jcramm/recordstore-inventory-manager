# frozen_string_literal: true

require './lib/models/album'
require './lib/models/artist'
require './lib/models/base'
require 'csv'

module Imports
  class PipeSerializer

    HEADER = %w[quantity format year artist_name title].freeze

    def serialize(data)
      objs = []
      CSV.parse(data, { headers: HEADER, col_sep: '|' }) do |row|
        hsh = row.to_h
        hsh.transform_values! { |v| Models::Base.format_string(v) }
        artist = Models::Artist.new('name' => hsh['artist_name'])
        objs.push(artist)
        hsh['artist_id'] = artist.generate_id
        album = Models::Album.new(hsh)
        objs.push(album)
        hsh['album_id'] = album.generate_id
        inventory_item = Models::InventoryItem.new(hsh)
        existing_record = Models::InventoryItem.find(inventory_item.generate_id)
        if existing_record
          existing_record.add_inventory(hsh['quantity'])
          inventory_item = existing_record
        end
        objs.push(inventory_item)
      end
      objs
    end
  end
end
