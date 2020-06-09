require './lib/models/album'
require './lib/models/artist'
require './lib/models/inventory_item'

module Views
  class Album

    def initialize(album)
      raise ArgumentError.new('album should be of type Album') unless album.is_a? Models::Album
      @album = album
    end

    def render
      artist = Models::Artist.where(id: @album.artist_id).first
      inventory = ""
      inventory_items.each do |item|
        inventory += render_item(item)
      end
      <<-HEREDOC
        Artist: #{format_string(artist.name)}
        Album: #{format_string(@album.title)}
        Released: #{@album.year}
        #{inventory}
      HEREDOC
    end

    def format_string(str)
      str.split.map(&:capitalize).join(' ')
    end

    def inventory_items
      Models::InventoryItem.where(album_id: @album.id)
    end

    def render_item(item)
      "#{format_string(item.format)}(#{item.quantity}): #{item.id}\n\t"
    end
  end
end