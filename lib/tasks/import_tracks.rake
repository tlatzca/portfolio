namespace :tracks do
  desc "楽曲のパラメータを分析し、データベースに保存する"
  task import: :environment do
    track_hash = Itunes::TrackSearcher.new(t-cophony).call
    parameter_hash = Gemini::TrackAnalyzer.new(track_hash).call
    parameter_vector = Parameters::TrackCalculator.new(parameter_hash).call

    Track.create(
      title: track["trackName"],
      artist: track["artistName"],
      itunes_id: track["trackId"],
      genre: parameter["genre"],
      release_date: track["releaseDate"],
      image_url: track["artworkUrl100"],
      preview_url: track["previewUrl"],
      applemusic_url: track["trackViewUrl"],
      spotify_url:
      details: parameter,
      parameter: parameter_vector
    )
  end
end
