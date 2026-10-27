class Book < ApplicationRecord
  attr_accessor :caption, :image_url, :rakuten_url

  validates :isbn, presence: true, uniqueness: true
  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :parameter, presence: true
  validates :analysis, presence: true
end
