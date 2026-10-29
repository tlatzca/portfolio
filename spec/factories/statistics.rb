FactoryBot.define do
  factory :statistic do
    media_type { "track" }
    average { [ 50.0, 50.0, 50.0, 50.0 ] }
    stddev { [ 10.0, 10.0, 10.0, 10.0 ] }
  end
end
