parameter_arrays = Track.pluck(:parameter).map do |vector|
  vector.delete("[]").split(",").map(&:to_f)
end

values_by_axis = parameter_arrays.transpose

averages = values_by_axis.map do |values|
  values.sum / values.size.to_f
end

stddevs = values_by_axis.map.with_index do |values, i|
  variance = values.sum { |value| (value - averages[i]) ** 2 } / values.size.to_f
  Math.sqrt(variance)
end

stats = Statistics.find_or_initialize_by(media_type: "track")
stats.update!(
  valence_average: averages[0], valence_stddev: stddevs[0],
  energy_average: averages[1], energy_stddev: stddevs[1],
  acousticness_average: averages[2], acousticness_stddev: stddevs[2],
  weirdness_average: averages[3], weirdness_stddev: stddevs[3]
)

puts "track: #{parameter_arrays.size}件から統計を計算しました"
