module Parameters
  class TrackCalculator
    def initialize(parameter_hash)
      @parameter = parameter_hash
    end

    def call
      energy_sum = (
        @parameter["sound"]["energy"] +
        @parameter["melody"]["energy"] +
        @parameter["lyrics_worldview"]["energy"]
      )
      energy_average = energy_sum / 3
      energy = energy_average / 100

      weirdness_sum = (
        @parameter["sound"]["weirdness"] +
        @parameter["melody"]["weirdness"] +
        @parameter["lyrics_worldview"]["weirdness"]
      )
      weirdness_average = weirdness_sum / 3
      weirdness = weirdness_average / 100

      valence = @parameter["valence"]["value"]
      
      acousticness = @parameter["acousticness"]["value"]

      [ valence, energy, acousticness, weirdness ].to_s
    end
  end
end