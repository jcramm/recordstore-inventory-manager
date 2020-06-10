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
        artist = serialize_artist(hsh)
        album = serialize_album(hsh, artist)
        inventory_item = serialize_inventory_item(hsh, album)
        objs.push(artist, album, inventory_item)
      end
      objs
    end

    def serialize_artist(hsh)
      artist = Models::Artist.new('name' => hsh['artist_name'])
      artist
    end

    def serialize_album(hsh, artist)
      album = Models::Album.new(hsh)
      album.artist_id = artist.generate_id
      album
    end

    def serialize_inventory_item(hsh, album)
      inventory_item = Models::InventoryItem.new(hsh)
      inventory_item.album_id = album.generate_id
      existing_record = Models::InventoryItem.find(inventory_item.generate_id)
      if existing_record
        existing_record.add_inventory(hsh['quantity'])
        inventory_item = existing_record
      end
      inventory_item
    end
  end
end
