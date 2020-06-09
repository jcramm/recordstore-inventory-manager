require './lib/models/inventory_item'
require './lib/models/album'
require 'utilities'
require 'securerandom'

describe Models::InventoryItem do

  before do
    @title = 'Ágætis byrjun'
    @artist_id = Digest::MD5.hexdigest('Sigur Rós')
    @year = 1999
    @album = Models::Album.new({
      'title'     => @title,
      'artist_id' => @artist_id,
      'year'      => @year,
    })
    @album_id = @album.generate_id
    @format = "cd"
    @quantity = 2
    @inventory_item = Models::InventoryItem.new({
      'format'   => @format,
      'album_id' => @album_id,
      'quantity' => @quantity,
    })
  end

  context '#new' do
    it 'has a format' do
      expect(@inventory_item.format).to eql @format
    end

    it 'has a quantity' do
      expect(@inventory_item.quantity).to eql @quantity
    end

    it 'has an album id' do
      expect(@inventory_item.album_id).to eql @album_id
    end
  end

  context '#generate_id' do
    it 'generates a valid hex id' do
      id = @inventory_item.generate_id || ''
      expect(id.match?(ID_REGEX)).to be true
    end
  end

  context '#save' do
    it 'can be saved to a json file' do
      @inventory_item.save
      expect(Models::InventoryItem.find(@inventory_item.id).id).to eq @inventory_item.id
    end
  end

  context '.all' do
    it 'returns a list of inventory_items' do
      expect(Models::InventoryItem.all.first).to be_a Models::InventoryItem
    end
  end

  context '.where' do
    it 'allows me to search by inventory_item name' do
      expect(Models::InventoryItem.find(@inventory_item.generate_id)).to be_a Models::InventoryItem
    end
  end

  context '#add_inventory' do
    it 'increments quantity by one when no params are passed' do
      quantity = @inventory_item.quantity
      @inventory_item.add_inventory
      expect(@inventory_item.quantity).to eq(quantity + 1)
    end

    it 'increments quantity by the specified amount when params are passed' do
      quantity = @inventory_item.quantity
      n = 5
      @inventory_item.add_inventory(n)
      expect(@inventory_item.quantity).to eq(quantity + n)
    end
  end

  context '#sell_inventory' do
    it 'decrements quantity by one when no params are passed' do
      quantity = @inventory_item.quantity
      @inventory_item.sell_inventory
      expect(@inventory_item.quantity).to eq(quantity - 1)
    end

    it 'increments quantity by the specified amount when params are passed' do
      quantity = @inventory_item.quantity
      n = 2
      @inventory_item.sell_inventory(n)
      expect(@inventory_item.quantity).to eq(quantity - n)
    end

    it 'throws an error if the number to decrement is greater than the current stock' do
      n = 5
      expect{@inventory_item.sell_inventory(n)}.to raise_error(ArgumentError)
    end
  end

  context '#delete' do
    it 'allows me to delete a record' do
      @inventory_item.delete
      expect(Models::InventoryItem.find(@inventory_item.id)).to be nil
    end
  end
end