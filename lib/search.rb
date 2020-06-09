# frozen_string_literal: true

require './lib/models/album'
require './lib/models/artist'

class Search
  VALID_TERMS_MAPPING = {
    'artist' => {
      'class' => Models::Artist,
      'attribute' => 'name'
    },
    'album' => {
      'class' => Models::Album,
      'attribute' => 'title'
    },
    'released' => {
      'class' => Models::Album,
      'attribute' => 'released'
    }
  }.freeze

  def self.search(params)
    results = {}
    params.each do |key, value|
      klass = fetch_class(key)
      attribute = fetch_attribute(key)
      klass.where({ attribute => value }, 'like').each do |result|
        if result.is_a?(Models::Artist)
          Models::Album.where(artist_id: result.id).each { |album| results[album.id] = album }
        else
          results[result.id] = result
        end
      end
    end
    results.values
  end

  def self.fetch_class(term)
    mapping = VALID_TERMS_MAPPING[term] || {}
    mapping['class']
  end

  def self.fetch_attribute(term)
    mapping = VALID_TERMS_MAPPING[term] || {}
    mapping['attribute']
  end

end
