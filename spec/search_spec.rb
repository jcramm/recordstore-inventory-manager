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

  context '.search' do
    it 'returns a valid list of items' do
      expect(true).to be false
    end
  end
end
