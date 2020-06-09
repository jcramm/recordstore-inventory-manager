# frozen_string_literal: true

require 'digest'
require 'securerandom'
require 'json'
require './lib/errors/abstract_method_error'

module Models
  class Base

    attr_reader :id

    def initialize(params)
      @id = params['id']
    end

    def to_hash
      hsh = {}
      instance_variables.each do |var|
        key = var.to_s.tr('@', '')
        hsh[key] = instance_variable_get(var) if whitelist.include?(key)
      end
      hsh
    end

    def self.file_name
      name = self.name.to_s.split('::').last
      "#{name}.json"
    end

    def self.file_path
      "./data/#{file_name}"
    end

    def self.fetch_data
      file = File.new(file_path, 'a+')
      data = JSON.load file
      file.close
      data || {}
    end

    def save_file(data)
      json = JSON.generate(data)
      File.open(self.class.file_path, 'w') do |f|
        f.write(json)
      end
    end

    def save
      # fetch file, insert json at GUID
      @id ||= generate_id
      data = self.class.fetch_data
      data[id] = to_hash
      save_file data
      self
    end

    def delete
      data = self.class.fetch_data
      data.delete(id)
      save_file data
    end

    def self.all
      data = fetch_data
      data.values.map { |record| new(record) }
    end

    def self.where(params, type = 'exact')
      all.select do |record|
        is_valid = params.map { |key, value| match(record.instance_variable_get('@' + key.to_s), value, type) }
        is_valid.inject(:|)
      end
    end

    def self.find(id)
      data = fetch_data
      data[id] ? new(data[id]) : nil
    end

    def self.match(value, term, type = 'exact')
      value = value.to_s.downcase
      term = term.to_s.downcase
      case type
      when 'like'
        value.include? term
      else
        value == term
      end
    end

    def generate_id
      SecureRandom.hex
    end

    def whitelist
      raise Errors::AbstractMethodError, 'Abstract method called'
    end

    def self.format_string(str)
      str.downcase.strip
    end
  end
end
