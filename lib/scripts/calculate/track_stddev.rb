parameter_arrays = Track.pluck(:parameter).map do |vector|
  vector.delete("[]").split(",").map(&:to_f)
end

values_by_axis = parameter_arrays.transpose

average = values_by_axis.map do |values|
  values.sum / values.size.to_f
end

stddev = values_by_axis.map.with_index do |values, i|
  variance = values.sum { |value| (value - average[i]) ** 2 } / values.size.to_f
  Math.sqrt(variance)
end

statistic = Statistic.find_or_initialize_by(media_type: "track")
statistic.update!(
  average: average,
  stddev: stddev
)
