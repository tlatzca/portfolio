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

      rakuten_hashes = JSON.parse(response.body)["Items"].map { _1["Item"] }
      return nil if rakuten_hashes.blank?

      rakuten_hashes.delete_if do |b|
        b["author"].blank?
      end
      return nil if rakuten_hashes.blank?

      isbn_array = rakuten_hashes.map { |b| b["isbn"] }

      openbd_hash = Openbd::BookFetcher.new(isbn_array).call
      return nil unless openbd_hash

      rakuten_hash = rakuten_hashes[openbd_hash[:index]]

      {
        isbn: openbd_hash[:isbn],
        openbd_title: openbd_hash[:title],
        openbd_author: openbd_hash[:author],
        title: rakuten_hash["title"],
        author: rakuten_hash["author"],
        caption: rakuten_hash["itemCaption"],
        image_url: rakuten_hash["largeImageUrl"],
        rakuten_url: rakuten_hash["itemUrl"]
      }
    end
  end
end