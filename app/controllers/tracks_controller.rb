class TracksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    uri = URI.parse("https://itunes.apple.com/search")
    uri.query = URI.encode_www_form({
      lang: "ja_jp",
      country: "jp",
      limit: 1,
      media: "music",
      term: track_params[:query]
    })

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      @track = JSON.parse(response.body)["results"]
    else
      @track = []
    end
  end

  private

  def track_params
    params.permit(:query)
  end
end
