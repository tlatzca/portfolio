class BooksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    if track_params[:itunes_id].present?
      @track = Track.find_by(itunes_id: track_params[:itunes_id])
      track_hash = Itunes::TrackFetcher.new(@track.itunes_id).call.first
      return if track_hash.blank?

      @track.merge_track_hash(track_hash)

      z_score = @track.z_score
    else
      return redirect_to root_path if track_params[:query].blank?

      track_hash = Itunes::TrackSearcher.new(track_params[:query]).call
      return if track_hash.blank?

      @track = Track.new(track_hash[:display])
      analysis = Gemini::TrackAnalyzer.new(track_hash[:analysis]).call
      parameter = Parameter::TrackCalculator.new(analysis).call
      z_score = Zscore::TrackCalculator.new(parameter).call
    end

    books = Match::BookFinder.new(z_score).call
    book_hashes = Rakuten::BookFetcher.new(books.map(&:isbn).join(" ")).call
    @books = books.filter_map { |book| book.merge_by_isbn(book_hashes) }
  end

  private

  def track_params
    params.permit(:query, :itunes_id)
  end
end
