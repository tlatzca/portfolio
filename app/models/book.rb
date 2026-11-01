class Book < ApplicationRecord
  attr_accessor :caption, :image_url, :rakuten_url

  validates :isbn, presence: true, uniqueness: true
  validates :title, presence: true
  validates :author, presence: true
  validates :genre, presence: true
  validates :parameter, presence: true
  validates :analysis, presence: true

  def merge_book_hash(book_hash)
    self.title = book_hash["title"]
    self.author = book_hash["author"]
    self.caption = book_hash["itemCaption"]
    self.image_url = book_hash["largeImageUrl"]
    self.rakuten_url = book_hash["itemUrl"]
    self
  end
  
  def merge_by_isbn(book_hashes)
    book_hash = book_hashes.find { |b| b["isbn"] == isbn }
    return nil if book_hash.blank?

    self.merge_book_hash(book_hash)
  end
end
