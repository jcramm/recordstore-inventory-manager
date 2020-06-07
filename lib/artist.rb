require 'model'

class Artist < Model

  attr_reader :id
  attr_accessor :name

  def initialize(params)
    super(params)
    @name = params['name']
  end

  def whitelist
    %w[ name id]
  end
end