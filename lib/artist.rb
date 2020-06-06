require 'securerandom'

class Artist

  attr_reader :name, :id

  def initialize(params)
    @name = params[:name]
    @id = params[:id] || SecureRandom.uuid
  end
end