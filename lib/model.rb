require 'securerandom'
require 'json'
require 'abstract_method_error'

class Model

  attr_reader :id, :updated_at

  def initialize(params)
    @id = params['id'] || SecureRandom.uuid
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
    return "#{self.name}.json"
  end

  def self.file_path
    "./data/#{file_name}"
  end

  # TODO
  # - what if the file doesn't exist
  def self.get_data
    file = File.open file_path
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
    data = self.class.get_data
    data[@id] = to_hash
    save_file data
  end

  def delete
    data = self.class.get_data
    data.delete(@id)
    save_file data
  end

  def self.all
    data = get_data
    data.values.map { |record| self.new(record)}
  end

  def self.where(params)
    all.select do |record|
      # we need to apply the values and keys as a search criteria
      is_valid = params.map {|key, value| record.instance_variable_get('@'+ key.to_s) == value}
      is_valid.inject(:|)
    end
  end

  def whitelist
    raise AbstractMethodError, 'Abstract method called'
  end
end