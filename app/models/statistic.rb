class Statistic < ApplicationRecord
  validates :media_type, presence: true
  validates :average, presence: true
  validates :stddev, presence: true
end
