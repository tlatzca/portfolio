class BooksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    @track_hash = Itunes::TrackSearcher.new(track_params[:query]).call
    analysis = Gemini::TrackAnalyzer.new(@track_hash).call
    parameter = Parameter::TrackCalculator.new(analysis).call
    z_score = Zscore::TrackCalculator.new(parameter).call

    books = Match::BookFinder.new(z_score).call
    @books = Rakuten::BookFetcher.new(books).call
  end

  private

  def track_params
    params.permit(:query)
  end
end
