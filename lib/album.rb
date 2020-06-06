require 'securerandom'

class Album

  attr_reader :title, :id, :artist_id, :year, :format

  def initialize(params)
    @title = params[:title]
    @id = params[:id] || SecureRandom.uuid
    @artist_id = params[:artist_id]
    @year = params[:year]
    @format = params[:format]
  end
end