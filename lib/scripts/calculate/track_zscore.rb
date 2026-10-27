statistic = Statistic.find_by(media_type: "track")

Track.find_each do |track|
  parameter = track.parameter.delete("[]").split(",").map(&:to_f)

  z_score = parameter.zip(statistic.average, statistic.stddev).map do |param, avg, sd|
    (param - avg) / sd
  end

  track.update!(z_score: z_score.to_s)
end
