require "net/http"
require "uri"

Book.find_each do |book|
  openbd_hash = Openbd::BookFetcher.new(book.isbn).call

  book.update(
    title: openbd_hash[:title],
    author: openbd_hash[:author]
  )

  sleep(0.1)
end
