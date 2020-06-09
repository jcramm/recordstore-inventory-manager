# frozen_string_literal: true

require './lib/models/album'
require 'digest'
require 'utilities'
require 'securerandom'

describe Models::Album do
  before do
    @title = 'Ágætis byrjun'
    @artist_id = Digest::MD5.hexdigest('Sigur Rós')
    @year = 1999
    @album = Models::Album.new({
                                 'title' => @title,
                                 'artist_id' => @artist_id,
                                 'year' => @year
                               })
    @album_id = @album.generate_id
    @format = 'cd'
    @quantity = 2
    @inventory_item = Models::InventoryItem.new({
                                                  'format' => @format,
                                                  'album_id' => @album_id,
                                                  'quantity' => @quantity
                                                })
  end

  context '#new' do
    it 'has a title' do
      expect(@album.title).to eql @title
    end

    it 'has an artist guid' do
      artist_id = @album.artist_id || ''
      expect(artist_id.match?(ID_REGEX)).to be true
    end

    it 'has an release year' do
      expect(@album.year).to be @year
    end
  end

  context '#generate_id' do
    it 'has a guid' do
      id = @album.generate_id || ''
      expect(id.match?(ID_REGEX)).to be true
    end
  end

  context '#save' do
    it 'can be saved to a json file' do
      @album.save
      expect(Models::Album.find(@album.id).id).to eq @album.id
    end
  end

  context '.all' do
    it 'returns a list of albums' do
      expect(Models::Album.all.first).to be_a Models::Album
    end
  end

  context '.find' do
    it 'returns an album when provided with a valid ID' do
      expect(Models::Album.find(@album_id).id).to eq @album_id
    end

    it 'returns nil when provided with an invalid ID' do
      expect(Models::Album.find('invalid_id')).to be nil
    end
  end

  context '.where' do
    it 'allows me to search by album name' do
      expect(Models::Album.where(title: @title).first.title).to eq @title
    end
  end

  context '#delete' do
    it 'allows me to delete a record' do
      album = Models::Album.where(title: @title).first
      id = album.id
      album.delete
      expect(Models::Album.find(id)).to be nil
    end
  end
end
