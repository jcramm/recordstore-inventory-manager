#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/views/inventory_item/sell'
require './lib/models/inventory_item'

id = ARGV[0]

inventory = Models::InventoryItem.find(id)
inventory.sell_inventory
inventory.save
puts Views::InventoryItem::Sell.new(inventory).render
