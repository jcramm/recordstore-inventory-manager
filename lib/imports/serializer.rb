# frozen_string_literal: true

require './lib/imports/csv_serializer'
require './lib/imports/pipe_serializer'

module Imports
  class Serializer

    def self.for(type)
      case type
      when '.csv'
        CsvSerializer.new
      when '.pipe'
        PipeSerializer.new
      else
        raise 'Invalid Format'
      end
    end
  end
end
