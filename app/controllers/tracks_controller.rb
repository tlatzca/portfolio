class TracksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    return redirect_to root_path if book_params[:query].blank?

    @book_hash = Rakuten::BookSearcher.new(book_params[:query]).call
    analysis = Gemini::BookAnalyzer.new(@book_hash).call
    parameter = Parameter::BookCalculator.new(analysis).call
    z_score = Zscore::BookCalculator.new(parameter).call

    tracks = Match::TrackFinder.new(z_score).call
    @tracks = Itunes::TrackFetcher.new(tracks).call
  end

  private

  def book_params
    params.permit(:query)
  end
end
