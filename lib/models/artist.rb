require './lib/models/base'

module Models
  class Artist < Base

    attr_accessor :name

    def initialize(params)
      super(params)
      @name = params['name']
    end

    def generate_id
      raise ArgumentError.new('Name is required') unless @name
      Digest::MD5.hexdigest(@name)
    end

    def whitelist
      %w[name id]
    end
  end
end