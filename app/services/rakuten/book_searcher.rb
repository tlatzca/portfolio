module Rakuten
  class BookSearcher
    def initialize(query)
      @query = query
    end

    def call
      uri = URI.parse("https://openapi.rakuten.co.jp/services/api/BooksTotal/Search/20170404")

      uri.query = URI.encode_www_form({
        applicationId: ENV["RAKUTEN_API_ID"],
        accessKey: ENV["RAKUTEN_API_KEY"],
        format: "json",
        keyword: @query
      })

      request = Net::HTTP::Get.new(uri)
      request["Referer"] = "https://myapp-ih54.onrender.com/"
      request["Origin"] = "https://myapp-ih54.onrender.com/"

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      return nil unless response.is_a?(Net::HTTPSuccess)

      book_hashes = JSON.parse(response.body)["Items"]&.map { _1["Item"] } || []

      book_hash = book_hashes.find do |b|
        b["author"].present? && b["itemCaption"].present?
      end
      book_hash ||= book_hashes.find do |b|
        b["author"].present?
      end
      return nil unless book_hash
      
      {
        title: book_hash["title"],
        author: book_hash["author"],
        caption: book_hash["itemCaption"],
        image_url: book_hash["largeImageUrl"],
        rakuten_url: book_hash["itemUrl"]
      }
    end
  end
end