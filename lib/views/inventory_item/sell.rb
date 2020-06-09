require './lib/models/album'
require './lib/models/artist'
require './lib/models/inventory_item'


module Views
  module InventoryItem
    class Sell

      def initialize(item)
        raise ArgumentError.new('item should be of type InventoryItem') unless item.is_a? Models::InventoryItem
        @item = item
      end

      # TODO
      # replace with find when its built
      def render
        album = Models::Album.where(id: @item.album_id).first
        artist = Models::Artist.where(id: album.artist_id).first
        "Removed 1 #{@item.format} of #{album.title} by #{artist.name} from the inventory"
      end
    end
  end
end