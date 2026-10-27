module Parameter
  class TrackCalculator
    def initialize(analysis)
      @analysis = analysis
    end

    def call
      energy_sum = (
        @analysis["sound"]["energy"] +
        @analysis["melody"]["energy"] +
        @analysis["lyrics_worldview"]["energy"]
      )
      energy_average = energy_sum / 3.0
      energy = energy_average / 100.0

      weirdness_sum = (
        @analysis["sound"]["weirdness"] +
        @analysis["melody"]["weirdness"] +
        @analysis["lyrics_worldview"]["weirdness"]
      )
      weirdness_average = weirdness_sum / 3.0
      weirdness = weirdness_average / 100.0

      valence = @analysis["valence"]["value"] /100.0

      acousticness = @analysis["acousticness"]["value"] /100.0

      [ valence, energy, acousticness, weirdness ]
    end
  end
end
