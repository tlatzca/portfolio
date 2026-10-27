module Itunes
  class TrackFetcher
    def initialize(tracks)
      @tracks = tracks
    end

    def call
      return [] if @tracks.blank?

      uri = URI.parse("https://itunes.apple.com/lookup")
      uri.query = URI.encode_www_form({
        lang: "ja_jp",
        country: "jp",
        media: "music",
        id: @tracks.map(&:itunes_id).join(",")
      })

      response = Net::HTTP.get_response(uri)
      return nil unless response.is_a?(Net::HTTPSuccess)

      track_hashes = JSON.parse(response.body)["results"]

      @tracks.each do |track|
        track_hash = track_hashes.find { |t| t["trackId"] == track.itunes_id }

        if track_hash
          track.image_url = track_hash["artworkUrl100"]
          track.preview_url = track_hash["previewUrl"]
          track.applemusic_url = track_hash["trackViewUrl"]
        else
          track.destroy
        end
      end
    end
  end
end
