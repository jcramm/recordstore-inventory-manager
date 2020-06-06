require 'securerandom'

class Artist

  attr_reader :name, :uuid

  def initialize(params)
    @name = params[:name]
    @uuid = params[:uuid] || SecureRandom.uuid
  end
end