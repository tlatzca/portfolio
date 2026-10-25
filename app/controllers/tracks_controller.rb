class TracksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    @book_hash = Rakuten::BookSearcher.new(book_params[:query]).call
    parameter_hash = Gemini::BookAnalyzer.new(@book_hash).call
    parameter_vector = Parameters::BookCalculator.new(parameter_hash).call

    @tracks = Match::TrackFinder.new(parameter_vector).call
    @tracks = Itunes::TrackFetcher.new(@tracks).call
  end

  private

  def book_params
    params.permit(:query)
  end
end
