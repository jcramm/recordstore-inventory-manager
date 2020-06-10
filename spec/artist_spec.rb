# frozen_string_literal: true

require './lib/models/artist'
require 'utilities'
require 'securerandom'

describe Models::Artist do
  context '#new' do
    before do
      @name = 'Sigur Rós'
      @artist = Models::Artist.new('name' => @name)
    end

    it 'has a name' do
      expect(@artist.name).to eql @name
    end
  end

  context '#generate_id' do
    before do
      @name = 'Sigur Rós'
      @artist = Models::Artist.new('name' => @name)
    end

    it 'generates a valid hex id' do
      id = @artist.generate_id || ''
      expect(id.match?(ID_REGEX)).to be true
    end
  end

  context '#save' do
    before do
      @name = 'Sigur Rós'
      @artist = Models::Artist.new('name' => @name)
    end

    it 'can be saved to a json file' do
      @artist.save
      expect(Models::Artist.find(@artist.id).id).to eq @artist.id
    end
  end

  context '.all' do
    it 'returns a list of artists' do
      expect(Models::Artist.all.first).to be_a Models::Artist
    end
  end

  context '.where' do
    before do
      @name = 'Sigur Rós'
    end

    it 'allows me to search by artist name' do
      expect(Models::Artist.where(name: @name).first.name).to eq @name
    end
  end

  context '#delete' do
    before do
      @name = 'Sigur Rós'
    end

    it 'allows me to delete a record' do
      artist = Models::Artist.where(name: @name).first
      id = artist.id
      artist.delete
      expect(Models::Artist.find(id)).to be nil
    end
  end
end
