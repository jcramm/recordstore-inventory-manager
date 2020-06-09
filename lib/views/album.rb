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
        Artist: #{artist.name}
        Album: #{@album.title}
        Released: #{@album.year}

      HEREDOC
    end
  end
end