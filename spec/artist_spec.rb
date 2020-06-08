require './lib/artist'
require 'spec_utilities'
require 'securerandom'

describe Artist do

  context '#new' do
    before do
      @name = 'Sigur Rós'
      @artist = Artist.new('name' => @name)
    end

    it 'has a name' do
      expect(@artist.name).to eql @name
    end
  end

  context '#generate_id' do
    before do
      @name = 'Sigur Rós'
      @artist = Artist.new('name' => @name)
    end

    it 'generates a valid hex id' do
      id = @artist.generate_id || ''
      expect(id.match?(ID_REGEX)).to be true
    end
  end

  context '#save' do
    before do
      @name = 'Sigur Rós'
      @artist = Artist.new('name' => @name)
    end

    it 'can be saved to a json file' do
      @artist.save
      expect(Artist.where(id: @artist.id).first.id).to eq @artist.id
    end
  end

  context '.all' do
    it 'can be saved to a json file' do
      expect(Artist.all.first.name).to eq 'Sigur Rós'
    end
  end

  context '.where' do
    before do
      @name = 'Sigur Rós'
    end

    it 'allows me to search by artist name' do
      expect(Artist.where(name: @name).first.name).to eq @name
    end
  end

  context '#delete' do
    before do
      @name = 'Sigur Rós'
    end

    it 'allows me to delete a record' do
      artist = Artist.where(name: @name).first
      id = artist.id
      artist.delete
      expect(Artist.where(id: id).empty?).to be true
    end
  end
end