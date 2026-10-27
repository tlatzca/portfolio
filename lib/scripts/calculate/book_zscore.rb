statistic = Statistic.find_by(media_type: "book")

Book.find_each do |book|
  parameter = book.parameter.delete("[]").split(",").map(&:to_f)

  z_score = parameter.zip(statistic.average, statistic.stddev).map do |param, avg, sd|
    (param - avg) / sd
  end

  book.update!(z_score: z_score.to_s)
end
