# frozen_string_literal: true

require './lib/models/album'
require './lib/models/artist'
require './lib/models/inventory_item'

module Views
  module Album
    class Show

      def initialize(album)
        @album = album
      end

      def render
        return nil unless @album.is_a? Models::Album
        artist = Models::Artist.find(@album.artist_id)
        inventory = ''
        inventory_items.each do |item|
          inventory += render_item(item)
        end
        <<~HEREDOC
          \tArtist: #{format_string(artist.name)}
          \tAlbum: #{format_string(@album.title)}
          \tReleased: #{@album.year}
          #{inventory}
        HEREDOC
      end

      def format_string(str)
        str.split.map(&:capitalize).join(' ')
      end

      def inventory_items
        Models::InventoryItem.where(album_id: @album.id).sort_by(&:format)
      end

      def render_item(item)
        "\t#{format_string(item.format)}(#{item.quantity}): #{item.id}\n"
      end
    end
  end
end
