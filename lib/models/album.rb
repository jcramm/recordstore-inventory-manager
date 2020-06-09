require './lib/models/base'
require 'digest'

module Models
  class Album < Base

    attr_reader :title, :artist_id, :year, :format

    def initialize(params)
      super(params)
      @title = params['title']
      @artist_id = params['artist_id']
      @year = params['year']
    end

    def generate_id
      raise ArgumentError.new('Missing required fields') if !@title || !@artist_id
      Digest::MD5.hexdigest(@title  + @artist_id)
    end

    def whitelist
      %w[title id artist_id year format]
    end

  end
end