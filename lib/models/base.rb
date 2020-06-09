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
      whitelisted = instance_variables.each do |var|
        key = var.to_s.tr("@","")
        hsh[key] = instance_variable_get(var) if whitelist.include?(key)
      end
      hsh
    end

    def self.file_name
      name = self.name.to_s.split('::').last
      return "#{name}.json"
    end

    def self.file_path
      "./data/#{file_name}"
    end

    def self.get_data
      file = File.new(file_path, 'a+')
      data = JSON.load file
      file.close
      data || {}
    end

    def save_file(data)
      json = JSON.generate(data)
      File.open(self.class.file_path,"w") do |f|
        f.write(json)
      end
    end

    def save
      # fetch file, insert json at GUID
      @id ||= generate_id
      data = self.class.get_data
      data[id] = to_hash
      save_file data
      return self
    end

    def delete
      data = self.class.get_data
      data.delete(id)
      save_file data
    end

    def self.all
      data = get_data
      data.values.map { |record| self.new(record)}
    end

    def self.where(params)
      all.select do |record|
        is_valid = params.map {|key, value| record.instance_variable_get('@'+ key.to_s) == value }
        is_valid.inject(:|)
      end
    end

    def generate_id
      SecureRandom.hex
    end

    def whitelist
      raise Errors::AbstractMethodError, 'Abstract method called'
    end

    def format_string(str)
      str.split.map(&:capitalize).join(' ')
    end
  end
end