module Parameters
  class BookCalculator
    def initialize(parameter_hash)
      @parameter = parameter_hash
    end

    def call
      energy_sum = (
        @parameter["story_progression"]["energy"] +
        @parameter["prose_style"]["energy"] +
        @parameter["worldview"]["energy"]
      )
      energy_average = energy_sum / 3
      energy = energy_average / 100

      weirdness_sum = (
        @parameter["story_progression"]["weirdness"] +
        @parameter["prose_style"]["weirdness"] +
        @parameter["worldview"]["weirdness"]
      )
      weirdness_average = weirdness_sum / 3
      weirdness = weirdness_average / 100

      valence = @parameter["valence"]["value"] / 100

      acousticness = @parameter["acousticness"]["value"] / 100

      [ valence, energy, acousticness, weirdness ].to_s
    end
  end
end