# frozen_string_literal: true

require './lib/models/album'
require './lib/models/artist'
require './lib/models/inventory_item'
require './lib/models/base'
require 'csv'

module Imports
  class CsvSerializer

    HEADER = %w[artist_name title format year].freeze

    def serialize(data)
      objs = []
      CSV.parse(data, headers: HEADER) do |row|
        hsh = row.to_h
        if !row_is_valid?(hsh)
          puts "row #{row.inspect} rejected\n"
          next
        end
        hsh.transform_values! { |v| Models::Base.format_string(v) }
        artist = serialize_artist(hsh)
        album = serialize_album(hsh, artist)
        inventory_item = serialize_inventory(hsh, album)
        objs.push(artist, album, inventory_item)
      end
      objs
    end

    def row_is_valid?(hsh)
      required_fields = HEADER
      required_fields.map { |k| !hsh[k].nil? }.reduce(:&)
    end

    def serialize_artist(hsh)
      Models::Artist.new('name' => hsh['artist_name'])
    end

    def serialize_album(hsh, artist)
      album = Models::Album.new(hsh)
      album.artist_id = artist.generate_id
      album
    end

    def serialize_inventory(hsh, album)
      inventory_item = Models::InventoryItem.new(hsh)
      inventory_item.album_id = album.generate_id
      inventory_item = Models::InventoryItem.find(inventory_item.generate_id) || inventory_item
      inventory_item.add_inventory
      inventory_item
    end
  end
end
