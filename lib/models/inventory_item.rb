# frozen_string_literal: true

require './lib/models/base'

module Models
  class InventoryItem < Base
    attr_accessor :format, :album_id, :quantity

    VALID_FORMATS = %w[cd vinyl tape].freeze

    def initialize(params)
      super(params)
      raise ArgumentError, "Invalid format #{params['format']}" unless VALID_FORMATS.include? params['format']

      @format = params['format']
      @album_id = params['album_id']
      @quantity = params['quantity'].to_i || 0
    end

    def generate_id
      raise ArgumentError, 'missing required fields' if !@format || !@album_id

      Digest::MD5.hexdigest(@format + @album_id)
    end

    def whitelist
      %w[format id album_id quantity]
    end

    def add_inventory(num = 1)
      @quantity ||= 0
      @quantity += num.to_i
    end

    def sell_inventory(num = 1)
      @quantity ||= 0
      raise ArgumentError, 'Not Enough Stock' if num.to_i > @quantity

      @quantity -= num.to_i
    end

    def album
      Album.find(@album_id)
    end
  end
end
