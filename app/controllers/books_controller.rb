class BooksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    @track_hash = Itunes::TrackSearcher.new(track_params[:query]).call
    parameter_hash = Gemini::TrackAnalyzer.new(@track_hash).call
    parameter_vector = Parameters::TrackCalculator.new(parameter_hash).call

    @books = Match::BookFinder.new(parameter_vector).call
    @books = Rakuten::BookFetcher.new(@books).call
  end

  private

  def track_params
    params.permit(:query)
  end
end
