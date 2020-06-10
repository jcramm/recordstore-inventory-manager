# frozen_string_literal: true

require './lib/search'
require './lib/models/album'
require './lib/models/artist'

describe Search do

  context '.fetch_attribute' do
    it 'supports the term artist' do
      expect(Search.fetch_attribute('artist')).to eq 'name'
    end

    it 'supports the term album' do
      expect(Search.fetch_attribute('album')).to eq 'title'
    end

    it 'supports the term released' do
      expect(Search.fetch_attribute('released')).to eq 'year'
    end
  end

  context '.fetch_class' do
    it 'supports the term artist' do
      expect(Search.fetch_class('artist')).to be Models::Artist
    end

    it 'supports the term album' do
      expect(Search.fetch_class('album')).to be Models::Album
    end

    it 'supports the term released' do
      expect(Search.fetch_class('album')).to be Models::Album
    end
  end

  context '.fetch_term' do
    it 'supports the term artist' do
      expect(Search.fetch_sort_term('artist')).to eq 'artist_name'
    end

    it 'supports the term album' do
      expect(Search.fetch_sort_term('album')).to eq 'title'
    end

    it 'supports the term released' do
      expect(Search.fetch_sort_term('released')).to eq 'year'
    end
  end

  context '.search' do
    before do
      @title = 'Ágætis byrjun'.downcase
      @name = 'Sigur Rós'.downcase
      @year = 1514
      @artist = Models::Artist.new({ 'name' => @name })
      @artist_id = @artist.generate_id
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
      @inventory_item_id = @inventory_item.generate_id
      @artist.save
      @album.save
      @inventory_item.save
    end

    it 'returns a valid list of items when searching for artist' do
      expect(Search.search('artist', 'igu').first&.id).to eq @album_id
    end

    it 'returns a valid list of items when searching for album' do
      expect(Search.search('album', 'byr').first&.id).to eq @album_id
    end

    it 'returns a valid list of items when searching for release' do
      expect(Search.search('released', 1514).first&.id).to eq @album_id
    end

    it 'throws an error if an invalid term is supplied' do
      expect { Search.search('han', 'shot first').first }.to raise_error(ArgumentError)
    end

    after do
      @artist.delete
      @album.delete
      @inventory_item.delete
    end
  end
end
