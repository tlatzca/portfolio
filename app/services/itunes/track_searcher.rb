module Itunes
  class TrackSearcher
    def initialize(query)
      @query = query
    end

    def call
      uri = URI.parse("https://itunes.apple.com/search")
      uri.query = URI.encode_www_form({
        lang: "ja_jp",
        country: "jp",
        limit: 1,
        media: "music",
        term: @query
      })

      response = Net::HTTP.get_response(uri)
      return nil unless response.is_a?(Net::HTTPSuccess)

      track_hash = JSON.parse(response.body).dig("results", 0)
      return nil if track_hash.blank?

      {
        itunes_id: track_hash["trackId"],
        title: track_hash["trackName"],
        artist: track_hash["artistName"],
        album: track_hash["collectionName"],
        genre: track_hash["primaryGenreName"],
        image_url: track_hash["artworkUrl100"],
        preview_url: track_hash["previewUrl"],
        applemusic_url: track_hash["trackViewUrl"]
      }
    end
  end
end
