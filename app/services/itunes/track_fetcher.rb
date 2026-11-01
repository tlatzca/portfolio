module Itunes
  class TrackFetcher
    def initialize(itunes_id)
      @itunes_id = itunes_id
    end

    def call
      return [] if @itunes_id.blank?

      uri = URI.parse("https://itunes.apple.com/lookup")
      uri.query = URI.encode_www_form({
        lang: "ja_jp",
        country: "jp",
        media: "music",
        id: @itunes_id
      })

      response = Net::HTTP.get_response(uri)
      return [] unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)["results"]
    end
  end
end
