module Parameter
  class BookCalculator
    def initialize(analysis)
      @analysis = analysis
    end

    def call
      energy_sum = (
        @analysis["story_progression"]["energy"] +
        @analysis["prose_style"]["energy"] +
        @analysis["worldview"]["energy"]
      )
      energy_average = energy_sum / 3.0
      energy = energy_average / 100.0

      weirdness_sum = (
        @analysis["story_progression"]["weirdness"] +
        @analysis["prose_style"]["weirdness"] +
        @analysis["worldview"]["weirdness"]
      )
      weirdness_average = weirdness_sum / 3.0
      weirdness = weirdness_average / 100.0

      valence = @analysis["valence"]["value"] / 100.0

      acousticness = @analysis["acousticness"]["value"] / 100.0

      [ valence, energy, acousticness, weirdness ]
    end
  end
end
