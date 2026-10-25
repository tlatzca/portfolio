require "net/http"
require "uri"
require "csv"

file_path = Rails.root.join("db/data/import_track.csv")

CSV.foreach(file_path) do |row|
  query = row.join(" ")

  begin
    track_hash = Itunes::TrackSearcher.new(query).call
    if track_hash.blank?
      message = "iTunes検索失敗: #{query}"
      Rails.logger.warn(message)
      puts message
      next
    end

    parameter_hash = Gemini::TrackAnalyzer.new(track_hash).call
    if parameter_hash.blank?
      message = "gemini分析失敗: #{query}"
      Rails.logger.warn(message)
      puts message
      next
    end

    parameter_vector = Parameters::TrackCalculator.new(parameter_hash).call

    Track.create(
      itunes_id: track_hash[:itunes_id],
      parameter: parameter_vector,
      genre: parameter_hash["genre"],
      analysis: parameter_hash
    )

  rescue => e
    message = "エラー  #{e.message}: #{query}"
    Rails.logger.warn(message)
    puts message
  end

  sleep(1)
end

