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

    analysis = Gemini::BookAnalyzer.new(book_hash).call
    if analysis.blank?
      message = "gemini分析失敗: #{query}"
      Rails.logger.warn(message)
      puts message
      next
    end

    parameter_vector = Parameters::BookCalculator.new(analysis).call

    Book.create(
      isbn: book_hash[:isbn],
      title: book_hash[:openbd_title],
      author: book_hash[:openbd_author],
      parameter: parameter_vector,
      genre: parameter_hash["genre"],
      analysis: analysis
    )

  rescue => e
    message = "エラー  #{e.message}: #{query}"
    Rails.logger.warn(message)
    puts message
  end

  sleep(1)
end
