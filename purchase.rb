#!/usr/bin/env ruby
require './lib/views/inventory_item/sell'
require './lib/models/inventory_item'

id = ARGV[0]
# TODO
# change this to 
inventory = Models::InventoryItem.find(id)
inventory.sell_inventory
inventory.save
puts Views::InventoryItem::Sell.new(inventory).render