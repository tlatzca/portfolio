class TracksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    if book_params[:isbn].present?
      @book = Book.find_by(isbn: book_params[:isbn])
      book_hash = Rakuten::BookFetcher.new(@book.isbn).call.first
      return if book_hash.blank?

      @book.merge_book_hash(book_hash)

      z_score = @book.z_score
    else
      return redirect_to root_path if book_params[:query].blank?

      book_hash = Rakuten::BookSearcher.new(book_params[:query]).call
      return if book_hash.blank?

      @book = Book.new(book_hash[:display])
      analysis = Gemini::BookAnalyzer.new(book_hash[:analysis]).call
      parameter = Parameter::BookCalculator.new(analysis).call
      z_score = Zscore::BookCalculator.new(parameter).call
    end

    tracks = Match::TrackFinder.new(z_score).call
    track_hashes = Itunes::TrackFetcher.new(tracks.map(&:itunes_id).join(",")).call
    @tracks = tracks.filter_map { |track| track.merge_by_id(track_hashes) }
  end

  private

  def book_params
    params.permit(:query, :isbn)
  end
end
