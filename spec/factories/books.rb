FactoryBot.define do
  factory :book do
    sequence(:isbn) { |n| "#{n}" }
    title { "test_title" }
    author { "test_author" }
    genre { "Literary Fiction / Human Drama" }
    parameter { "[0.85,0.3,0.9,0.11666667]" }
    analysis {
      {
        "target_name" => "test_title",
        "prose_style" => {
          "energy" => 65,
          "reason" => "test_reason",
          "weirdness" => 15
        },
        "story_progression" => {
          "energy" => 70,
          "reason" => "test_reason",
          "weirdness" => 10
        },
        "worldview" => {
          "energy" => 40,
          "reason" => "test_reason",
          "weirdness" => 20
        },
        "valence" => {
          "value" => 65,
          "reason" => "test_reason"
        },
        "acousticness" => {
          "value" => 15,
          "reason" => "test_reason"
        },
        "genre_reason" => "test_genre_reason",
        "genre" => "Literary Fiction / Human Drama"
      }
    }
  end
end
