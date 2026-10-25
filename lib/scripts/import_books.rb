require "net/http"
require "uri"
require "csv"

file_path = Rails.root.join("db/data/import_book.csv")

CSV.foreach(file_path) do |row|
  query = row.first

  begin
    book_hash = Rakuten::BookSearcher.new(query).call
    if book_hash.blank?
      message = "書籍検索失敗: #{query}"
      Rails.logger.warn(message)
      puts message
      next
    end

    parameter_hash = Gemini::BookAnalyzer.new(book_hash).call
    if parameter_hash.blank?
      message = "gemini分析失敗: #{query}"
      Rails.logger.warn(message)
      puts message
      next
    end

    parameter_vector = Parameters::BookCalculator.new(parameter_hash).call
    Book.create(
      isbn: book_hash[:isbn],
      parameter: parameter_vector,
      genre: parameter_hash["genre"],
      analysis: parameter_hash
    )

  rescue => e
    message = "エラー  #{e.message}: #{query}"
    Rails.logger.warn(message)
    puts message
  end

  sleep(1)
end

