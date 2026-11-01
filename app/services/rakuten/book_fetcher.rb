module Rakuten
  class BookFetcher
    def initialize(isbn)
      @isbn = isbn
    end

    def call
      return [] if @isbn.blank?

      uri = URI.parse("https://openapi.rakuten.co.jp/services/api/BooksTotal/Search/20170404")

      uri.query = URI.encode_www_form({
        applicationId: ENV["RAKUTEN_API_ID"],
        accessKey: ENV["RAKUTEN_API_KEY"],
        format: "json",
        orFlag: 1,
        keyword: @isbn
      })

      request = Net::HTTP::Get.new(uri)
      request["Referer"] = "https://myapp-ih54.onrender.com/"
      request["Origin"] = "https://myapp-ih54.onrender.com/"

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      return [] unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)["Items"].map { _1["Item"] }
    end
  end
end
