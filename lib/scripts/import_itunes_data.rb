require "net/http"
require "uri"

Track.find_each do |track|
  uri = URI.parse("https://itunes.apple.com/lookup")
  uri.query = URI.encode_www_form({
    lang: "ja_jp",
    country: "jp",
    media: "music",
    id: track.itunes_id
  })

  response = Net::HTTP.get_response(uri)

  track_hash = JSON.parse(response.body)["results"][0]

  track.update(
    title: track_hash["trackName"],
    artist: track_hash["artistName"]
  )

  sleep(0.1)
end