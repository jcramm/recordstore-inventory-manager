# frozen_string_literal: true

require './lib/models/album'
require './lib/models/artist'

class Search
  VALID_TERMS_MAPPING = {
    'artist' => {
      'class' => Models::Artist,
      'attribute' => 'name',
      'sort_by' => 'artist_name',
      'asc' => 1
    },
    'album' => {
      'class' => Models::Album,
      'attribute' => 'title',
      'sort_by' => 'title',
      'asc' => 1
    },
    'released' => {
      'class' => Models::Album,
      'attribute' => 'year',
      'sort_by' => 'year',
      'asc' => -1
    },
    'format' => {
      'class' => Models::InventoryItem,
      'attribute' => 'format',
      'sort_by' => 'title',
      'asc' => -1
    }
  }.freeze

  def self.search(key, value)
    results = {}
    klass = fetch_class(key)
    attribute = fetch_attribute(key)
    raise ArgumentError, "Invalid query term #{key}" unless klass

    klass.where({ attribute => value }, 'like').each do |result|
      case result
      when Models::Artist
        result.albums.each { |album| results[album.id] = album }
      when Models::InventoryItem
        results[result.album_id] = result.album
      when Models::Album
        results[result.id] = result
      end
    end
    sort(results.values, key)
  end

  def self.sort(items, key)
    asc = sort_ascending(key)
    criteria = fetch_sort_term(key)
    items.sort { |i, j| asc * (i.send(criteria) <=> j.send(criteria)) }
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

  def self.sort_ascending(term)
    mapping = VALID_TERMS_MAPPING[term] || {}
    mapping['asc']
  end
end
