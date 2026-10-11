class BooksController < ApplicationController
  require 'net/http'
  require 'uri'
  
  def index
    uri = URI.parse("https://openapi.rakuten.co.jp/services/api/BooksTotal/Search/20170404")

    uri.query = URI.encode_www_form({ 
      format: "json",
      keyword: book_params[:query],
      applicationId: "4afa1179-b27e-4268-b841-9527ea5c0dec",
      accessKey: "pk_Kv3DMqh1VHmFyIO767T4f7BJTwGkbTGzQRF3wwuEFgb"
    })

    http_request = Net::HTTP::Get.new(uri)
    http_request['Referer'] = 'https://myapp-ih54.onrender.com/'
    http_request['Origin'] = 'https://myapp-ih54.onrender.com/'

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(http_request)
    end

    if response.is_a?(Net::HTTPSuccess)
      results = JSON.parse(response.body)["Items"] || []
    else
      results = []
    end

    @first_book = results.find do |result|
      result["Item"]["author"].present? &&
      result["Item"]["itemCaption"].present?
    end
    
    @first_book ||= results.find do |result|
      result["Item"]["author"].present?
    end
  end

  private

  def book_params
    params.permit(:query)
  end
end