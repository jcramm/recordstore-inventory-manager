# frozen_string_literal: true

require './lib/imports/import'

describe Imports::PipeSerializer do
  before do
    @hash = {
      'quantity' => 2,
      'format' => 'vinyl',
      'year' => 1999,
      'artist_name' => 'sigur rós',
      'title' => 'ágætis byrjun'
    }
    @artist = Models::Artist.new('name' => @hash['artist_name'])
    @album = Models::Album.new(@hash)
    @album.artist_id = @artist.generate_id
    @serializer = Imports::PipeSerializer.new
  end

  context '#serialize_artist' do
    it 'serializes an artist' do
      expect(@serializer.serialize_artist(@hash)).to be_an Models::Artist
    end
  end

  context '#serialize_album' do
    it 'serializes an album' do
      expect(@serializer.serialize_album(@hash, @artist)).to be_an Models::Album
    end
  end

  context '#serialize_inventory_item' do
    it 'serializes an inventory item' do
      expect(@serializer.serialize_inventory_item(@hash, @album)).to be_an Models::InventoryItem
    end
  end
end
