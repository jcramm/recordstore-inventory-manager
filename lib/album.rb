require 'model'

class Album < Model

  attr_reader :title, :id, :artist_id, :year, :format

  def initialize(params)
    super(params)
    @title = params['title']
    @artist_id = params['artist_id']
    @year = params['year']
    @format = params['format']
  end

  def whitelist
    %w[id title artist_id year format]
  end
end