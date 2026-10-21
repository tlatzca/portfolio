module Match
  class TrackFinder
    def initialize(parameter_vector)
      @parameter_vector = parameter_vector
    end

    def call
      Track.find_by_sql([
        "SELECT *,
        parameter <-> ?::vector
        AS l2_distance
        FROM tracks
        ORDER BY l2_distance LIMIT 6;",
        @parameter_vector
      ])
    end
  end
end