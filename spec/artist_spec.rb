require './lib/artist'
require 'spec_utilities'
require 'securerandom'

describe Artist do
  context "#new" do
    before do
      @name = 'Sigur Rós'
      @artist = Artist.new({name: @name})
    end

    it 'has a name' do
      expect(@artist.name).to eql @name
    end

    it 'has a guid' do
      uuid = @artist.id || ''
      expect(uuid.match?(UUID_REGEX)).to be true
    end
  end
end