FactoryBot.define do
  factory :track do
    sequence(:itunes_id) { |n| n }
    title { "test_title" }
    artist { "test_artist" }
    genre { "Electronic Pop" }
    parameter { "[0.75,0.5833333,0.05,0.15]" }
    analysis {
      {
        "genre" => "Electronic Pop",
        "sound" => {
          "energy" => 65,
          "reason" => "test_reason",
          "weirdness" => 15
        },
        "melody" => {
          "energy" => 70,
          "reason" => "test_reason",
          "weirdness" => 10
        },
        "valence" => {
          "value" => 65,
          "reason" => "test_reason"
        },
        "target_name" => "test_title",
        "acousticness" => {
          "value" => 15,
          "reason" => "test_reason"
        },
        "genre_reason" => "test_genre_reason",
        "lyrics_worldview" => {
          "energy" => 40,
          "reason" => "test_reason",
          "weirdness" => 20
        }
      }
    }
  end
end
