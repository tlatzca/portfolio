module Match
  class BookFinder
    def initialize(z_score)
      @z_score = z_score
    end

    def call
      Book.find_by_sql([
        "SELECT *,
        z_score <-> ?::vector
        AS l2_distance
        FROM books
        ORDER BY l2_distance LIMIT 8;",
        @z_score.to_s
      ])
    end
  end
end
