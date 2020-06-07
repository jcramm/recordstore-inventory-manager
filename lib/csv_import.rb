require './lib/artist'
require './lib/album'
require 'csv'

class Import

  def self.import(file_path)
    # get format, and normalize it as a hash
    type = File.extname(file_path)
    data = File.open file_path
    objs = serialize(type, data)
    objs.each {|o| o.save!}
  end

  def self.serialize(type, data)
    Serializer.for(type).serialize(data)
  end
end

class Serializer

  def self.for(type)
    case type
    when '.csv'
      CsvSerializer.new
    when '.pipe'
      raise 'Invalid Format'
    else
      raise 'Invalid Format'
    end
  end
end

class CsvSerializer

  HEADER = %w[artist_name title format year]

  def serialize(data)
    objs = []
    CSV.parse(data, headers: HEADER) do |row|
      hsh = row.to_h
      artist = Artist.new(name: hsh['artist_name'])
      objs.push(artist)
      hsh['artist_id'] = artist.id
      objs.push(Album.new(hsh))
    end
    objs
  end
end