class Track < ApplicationRecord
  attr_accessor :image_url, :preview_url, :applemusic_url

  validates :itunes_id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :artist, presence: true
  validates :genre, presence: true
  validates :parameter, presence: true
  validates :analysis, presence: true
end
