module Match
  class TrackFinder
    def initialize(z_score)
      @z_score = z_score
    end

    def call
      return [] if @z_score.blank?

      Track.find_by_sql([
        "SELECT *,
        parameter <-> ?::vector
        AS l2_distance
        FROM tracks
        ORDER BY l2_distance LIMIT 18;",
        @z_score.to_s
      ])
    end
  end
end
