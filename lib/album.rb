require './lib/model'
require 'digest'

class Album < Model

  attr_reader :title, :artist_id, :year, :format

  def initialize(params)
    super(params)
    @title = params['title']
    @artist_id = params['artist_id']
    @year = params['year']
    @format = params['format']
    @quantity = params['quantity']
  end

  def generate_id
    raise ArgumentError.new('Missing required fields') if !@title || !@format || !@artist_id
    Digest::MD5.hexdigest(@title  + @format + @artist_id)
  end

  def whitelist
    %w[title id artist_id year format]
  end

end