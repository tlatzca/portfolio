module Rakuten
  class BookFetcher
    def initialize(books)
      @books = books
    end

    def call
      uri = URI.parse("https://openapi.rakuten.co.jp/services/api/BooksTotal/Search/20170404")

      uri.query = URI.encode_www_form({
        applicationId: ENV["RAKUTEN_API_ID"],
        accessKey: ENV["RAKUTEN_API_KEY"],
        format: "json",
        orFlag: 1,
        keyword: @books.map(&:isbn).join(" ")
      })

      request = Net::HTTP::Get.new(uri)
      request["Referer"] = "https://myapp-ih54.onrender.com/"
      request["Origin"] = "https://myapp-ih54.onrender.com/"

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      book_hashes = JSON.parse(response.body)["Items"].map { _1["Item"] }
      return nil unless response.is_a?(Net::HTTPSuccess)

      @books.each do |book|
        book_hash = book_hashes.find { |b| b["isbn"] == book.isbn }

        if book_hash
          book.title = book_hash["title"]
          book.author = book_hash["author"]
          book.caption = book_hash["itemCaption"]
          book.image_url = book_hash["largeImageUrl"]
          book.rakuten_url = book_hash["itemUrl"]
        else
          book.destroy
        end
      end
    end
  end
end
