require './lib/models/album'
require 'digest'
require 'utilities'
require 'securerandom'

describe Models::Album do
  context "#new" do
    before do
      @title = 'Ágætis byrjun'
      @artist_id = Digest::MD5.hexdigest('Sigur Rós')
      @year = 1999
      @album = Models::Album.new({
        'title'     => @title,
        'artist_id' => @artist_id,
        'year'      => @year,
      })
    end

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
    before do
      @title = 'Ágætis byrjun'
      @artist_id = Digest::MD5.hexdigest('Sigur Rós')
      @year = 1999
      @format = 'tbd'
      @album = Models::Album.new({
        'title'     => @title,
        'artist_id' => @artist_id,
        'year'      => @year,
        'format'    => @format
      })
    end

    it 'has a guid' do
      id = @album.generate_id || ''
      expect(id.match?(ID_REGEX)).to be true
    end
  end

  context '#save' do
    before do
      @title = 'Ágætis byrjun'
      @artist_id = Digest::MD5.hexdigest('Sigur Rós')
      @year = 1999
      @format = 'tbd'
      @album = Models::Album.new({
        'title'     => @title,
        'artist_id' => @artist_id,
        'year'      => @year,
        'format'    => @format
      })
    end

    it 'can be saved to a json file' do
      @album.save
      expect(Models::Album.where(id: @album.id).first.id).to eq @album.id
    end
  end

  context '.all' do
    it 'returns a list of albums' do
      expect(Models::Album.all.first).to be_a Models::Album
    end
  end

  context '.where' do
    before do
      @title = 'Ágætis byrjun'
    end

    it 'allows me to search by album name' do
      expect(Models::Album.where(title: @title).first.title).to eq @title
    end
  end

  context '#delete' do
    before do
      @title = 'Ágætis byrjun'
    end

    it 'allows me to delete a record' do
      album = Models::Album.where(title: @title).first
      id = album.id
      album.delete
      expect(Models::Album.where(id: id).empty?).to be true
    end
  end
end