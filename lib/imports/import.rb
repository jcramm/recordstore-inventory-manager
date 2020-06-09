# frozen_string_literal: true

require './lib/imports/serializer'

module Imports
  class Import

    def self.import(file_path)
      # get format, and normalize it as a hash
      type = File.extname(file_path)
      data = File.open file_path
      objs = serialize(type, data)
      objs.each(&:save)
    end

    def self.serialize(type, data)
      Serializer.for(type).serialize(data)
    end
  end
end
