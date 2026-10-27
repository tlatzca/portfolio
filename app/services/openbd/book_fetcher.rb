module Openbd
  class BookFetcher
    def initialize(isbn)
      @isbn_array = Array(isbn)
    end

    def call
      isbn_string = @isbn_array.join(",")
      uri = URI.parse("https://api.openbd.jp/v1/get?isbn=#{isbn_string}")

      response = Net::HTTP.get_response(uri)
      return {} unless response.is_a?(Net::HTTPSuccess)

      openbd_hashes = JSON.parse(response.body)

      openbd_hashes.each_with_index do |openbd_hash, index|
        next unless openbd_hash

        summary = openbd_hash["summary"]

        return {
          index: index,
          isbn: summary["isbn"],
          title: summary["title"],
          author: summary["author"]
        }
      end

      {}
    end
  end
end
