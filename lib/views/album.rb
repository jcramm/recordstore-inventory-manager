require './lib/models/album'
require './lib/models/artist'

module Views
  class Album

    def initialize(album)
      raise ArgumentError.new('album should be of type Album') unless album.is_a? Models::Album
      @album = album
    end

    def render
      artist = Models::Artist.where(id: @album.artist_id).first
      <<-HEREDOC
        Artist: #{format_string(artist.name)}
        Album: #{format_string(@album.title)}
        Released: #{@album.year}

      HEREDOC
    end

    def format_string(str)
      str.split.map(&:capitalize).join(' ')
    end
  end
end