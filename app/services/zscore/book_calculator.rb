module Zscore
  class BookCalculator
    def initialize(parameter)
      @parameter = parameter
    end

    def call
      return [] if @parameter.blank?

      statistic = Statistic.find_by(media_type: "book")

      @parameter.zip(statistic.average, statistic.stddev).map do |param, avg, sd|
        (param - avg) / sd
      end
    end
  end
end
