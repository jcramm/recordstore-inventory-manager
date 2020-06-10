# frozen_string_literal: true

require './lib/models/album'
require './lib/models/artist'
require './lib/models/inventory_item'

module Views
  module InventoryItem
    class Sell

      def initialize(item)
        raise ArgumentError, 'item should be of type InventoryItem' unless item.is_a? Models::InventoryItem

        @item = item
      end

      def render
        album = Models::Album.find(@item.album_id)
        artist = Models::Artist.find(album.artist_id)
        "Removed 1 #{@item.format} of #{format_string(album.title)} by #{format_string(artist.name)} from the inventory \n"
      end

      def format_string(str)
        str.split.map(&:capitalize).join(' ')
      end
    end
  end
end
