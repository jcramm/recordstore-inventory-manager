require './lib/models/base'

module Models
  class InventoryItem < Base

    VALID_FORMATS = %w[ cd vinyl tape ]

    attr_accessor :format, :album_id, :quantity

    def initialize(params)
      super(params)
      raise ArgumentError.new("Invalid format #{params['format']}") unless VALID_FORMATS.include? params['format']
      @format = params['format']
      @album_id = params['album_id']
      @quantity = params['quantity'].to_i || 0
    end

    def generate_id
      raise ArgumentError.new('missing required fields') if !@format || !@album_id
      Digest::MD5.hexdigest(@format + @album_id)
    end

    def whitelist
      %w[format id album_id quantity]
    end

    def add_inventory(num=1)
      @quantity ||= 0
      @quantity += num.to_i
    end

    def sell_inventory(num=1)
      @quantity ||= 0
      raise ArgumentError.new('Not Enough Stock') if num.to_i > @quantity
      @quantity -= num.to_i
    end
  end
end