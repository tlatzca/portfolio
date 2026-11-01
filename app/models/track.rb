class Track < ApplicationRecord
  attr_accessor :image_url, :preview_url, :applemusic_url

  validates :itunes_id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :artist, presence: true
  validates :genre, presence: true
  validates :parameter, presence: true
  validates :analysis, presence: true

  def merge_track_hash(track_hash)
    self.image_url = track_hash["artworkUrl100"]
    self.preview_url = track_hash["previewUrl"]
    self.applemusic_url = track_hash["trackViewUrl"]
    self
  end
  
  def merge_by_id(track_hashes)
    track_hash = track_hashes.find { |t| t["trackId"] == itunes_id }
    return nil if track_hash.blank?

    self.merge_track_hash(track_hash)
  end
end
