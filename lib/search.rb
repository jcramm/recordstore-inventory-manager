# frozen_string_literal: true

require './lib/models/album'
require './lib/models/artist'

class Search
  VALID_TERMS_MAPPING = {
    'artist' => {
      'class' => Models::Artist,
      'attribute' => 'name',
      'sort_by' => 'artist_name'
    },
    'album' => {
      'class' => Models::Album,
      'attribute' => 'title',
      'sort_by' => 'title'
    },
    'released' => {
      'class' => Models::Album,
      'attribute' => 'year',
      'sort_by' => 'year'
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
    sort(results.values, fetch_sort_term(params.keys.first))
  end

  def self.sort(results, criteria)
    results.sort_by { |t| [t.send(criteria), t.year] }
  end

  def self.fetch_sort_term(term)
    mapping = VALID_TERMS_MAPPING[term] || {}
    mapping['sort_by']
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
