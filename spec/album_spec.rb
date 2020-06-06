require './lib/album'
require 'spec_utilities'
require 'securerandom'

describe Album do
  context "#new" do
    before do
      @title = 'Ágætis byrjun'
      @artist_id = "73175943-fdff-4a3d-a645-5b11f7edb670"
      @year = 1999
      @format = 'tbd'
      @album = Album.new({title: @title, artist_id: @artist_id, year: @year, format: @format})
    end

    it 'has a title' do
      expect(@album.title).to eql @title
    end

    it 'has a guid' do
      uuid = @album.id || ''
      expect(uuid.match?(UUID_REGEX)).to be true
    end

    it 'has an artist guid' do
      artist_id = @album.artist_id || ''
      expect(artist_id.match?(UUID_REGEX)).to be true
    end

    it 'has an release year' do
      expect(@album.year).to be @year
    end

    it 'has an format' do
      expect(@album.format).to be @format
    end
  end
end