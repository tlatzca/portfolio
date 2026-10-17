class TracksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    uri = URI.parse("https://openapi.rakuten.co.jp/services/api/BooksTotal/Search/20170404")

    uri.query = URI.encode_www_form({
      applicationId: ENV["RAKUTEN_API_ID"],
      accessKey: ENV["RAKUTEN_API_KEY"],
      format: "json",
      keyword: book_params[:query]
    })

    request = Net::HTTP::Get.new(uri)
    request["Referer"] = "https://myapp-ih54.onrender.com/"
    request["Origin"] = "https://myapp-ih54.onrender.com/"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      book_hashes = JSON.parse(response.body)["Items"]&.map { _1["Item"] } || []
    else
      book_hashes = []
    end

    book_hash = book_hashes.find do |b|
      b["author"].present? && b["itemCaption"].present?
    end

    book_hash ||= book_hashes.find do |b|
      b["author"].present?
    end

    if book_hash
      @book = Book.new
      @book.title = book_hash["title"]
      @book.author = book_hash["author"]
      @book.caption = book_hash["itemCaption"]
      @book.image_url = book_hash["largeImageUrl"]
      @book.rakuten_url = book_hash["itemUrl"]
    end

    uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash-lite:generateContent")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["X-goog-api-key"] = ENV["GEMINI_API_KEY"]
    request.body = {
      contents: [ {
        parts: [
          { text:
          "You are an expert who analyzes the atmosphere of a book and quantifies it using four parameters.

          Synthesize the provided input data and your knowledge of the target work to analyze and evaluate the work's atmosphere according to the following rules.

          ### 1. Extraction of Components
          For the target work, extract elements related to the following three categories.
          Categories: Plot/Story Progression, Prose Style/Tone, Worldview/Setting

          ### 2. Parameter Evaluation per Component
          For each of the three extracted components, evaluate the following four axis parameters individually as integer values from 0 to 100.
          * The four axes must be evaluated independently, without influencing one another (e.g., automatic correlations such as dark = quiet or intense = high tension are prohibited).
          * The components must also be evaluated independently of one another, based solely on the texture specific to each component (e.g., even if the Plot's energy is high, if the Prose Style is calm, the Prose Style's energy should be rated low).
          * Do not default to a safe middle value (40-60). Actively push each axis score toward the higher or lower end.
          * If you lack specific knowledge about the target work, do not supplement details with guesswork; reason only within a reasonable range based solely on the given input data.

          - valence (Brightness / Positivity)
            0: Tragic, melancholic ↔ 100: Cheerful, hopeful

          - energy (Intensity / Power)
            0: Static, calm, low stimulation ↔ 100: Intense, powerful

          - acousticness (Organic / Natural texture)
            0: Digital, mechanical ↔ 100: natural depiction, Lived-in

          - weirdness (Strangeness / Absurdity)
            0: Conventional, logical ↔ 100: Strange, absurd, surreal

          ### 3. Genre Determination
          Completely independent of the parameter evaluation in Step 2, output exactly one string selected from the list.
          * When selecting the genre, prioritize information specific to the target work itself over information about the author.

          ---

          [Input Data]
          - Title: #{@book.title}
          - Auhor: #{@book.author}
          - Caption: #{@book.caption}"
          }
        ]
      }],
      generationConfig: {
        responseFormat: {
          text: {
            mimeType: "APPLICATION_JSON",
            schema: {
              type: "object",
              properties: {
                target_name: {
                  type: "string",
                  description: "The title of the work being analyzed."
                },
                story_progression: {
                  type: "object",
                  description: "Analysis of the work's plot development and pacing.",
                  properties: {
                    reason: { type: "string", description: "The specific characteristics that justify the parameter values below." },
                    valence: { type: "integer", minimum: 0, maximum: 100 },
                    energy: { type: "integer", minimum: 0, maximum: 100 },
                    acousticness: { type: "integer", minimum: 0, maximum: 100 },
                    weirdness: { type: "integer", minimum: 0, maximum: 100 }
                  },
                  required: [ "reason", "valence", "energy", "acousticness", "weirdness" ]
                },
                prose_style: {
                  type: "object",
                  description: "Analysis of the work's writing style, voice, and tone.",
                  properties: {
                    reason: { type: "string", description: "The specific characteristics that justify the parameter values below." },
                    valence: { type: "integer", minimum: 0, maximum: 100 },
                    energy: { type: "integer", minimum: 0, maximum: 100 },
                    acousticness: { type: "integer", minimum: 0, maximum: 100 },
                    weirdness: { type: "integer", minimum: 0, maximum: 100 }
                  },
                  required: [ "reason", "valence", "energy", "acousticness", "weirdness" ]
                },
                worldview: {
                  type: "object",
                  description: "Analysis of the story's setting and the overall mood/atmosphere of that world.",
                  properties: {
                    reason: { type: "string", description: "The specific characteristics that justify the parameter values below." },
                    valence: { type: "integer", minimum: 0, maximum: 100 },
                    energy: { type: "integer", minimum: 0, maximum: 100 },
                    acousticness: { type: "integer", minimum: 0, maximum: 100 },
                    weirdness: { type: "integer", minimum: 0, maximum: 100 }
                  },
                  required: [ "reason", "valence", "energy", "acousticness", "weirdness" ]
                },
                genre_reason: {
                  type: "string",
                  description: "The rationale for the selected genre."
                },
                genre: {
                  type: "string",
                  enum: [
                    "Mystery / Suspense",
                    "Science Fiction",
                    "Fantasy",
                    "Coming-of-Age / Romance",
                    "Literary Fiction / Human Drama",
                    "Horror / Ghost Stories",
                    "Historical Fiction",
                    "Nonfiction / Essay"
                  ],
                  description: "The selected genre, chosen from the predefined list."
                }
              },
              required: [ "target_name", "story_progression", "prose_style", "worldview", "genre_reason", "genre" ]
            }
          }
        }
      }
    }.to_json

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      result_text = JSON.parse(response.body).dig("candidates", 0, "content", "parts", 0, "text") || []
      parameter = JSON.parse(result_text)
    else
      binding.break
    end

    valence_array = [
      parameter["story_progression"]["valence"],
      parameter["prose_style"]["valence"],
      parameter["worldview"]["valence"]
    ]
    valence_average = valence_array.sum.fdiv(valence_array.size)
    valence = valence_average / 100

    energy_array = [
      parameter["story_progression"]["energy"],
      parameter["prose_style"]["energy"],
      parameter["worldview"]["energy"]
    ]
    energy_average = energy_array.sum.fdiv(energy_array.size)
    energy = energy_average / 100

    acousticness_array = [
      parameter["story_progression"]["acousticness"],
      parameter["prose_style"]["acousticness"],
      parameter["worldview"]["acousticness"]
    ]
    acousticness_average = acousticness_array.sum.fdiv(acousticness_array.size)
    acousticness = acousticness_average / 100

    weirdness_array = [
      parameter["story_progression"]["weirdness"],
      parameter["prose_style"]["weirdness"],
      parameter["worldview"]["weirdness"]
    ]
    weirdness_average = weirdness_array.sum.fdiv(weirdness_array.size)
    weirdness = weirdness_average / 100

    parameter_vector = [ valence, energy, acousticness, weirdness ].to_s

    @tracks = Track.find_by_sql([
      "SELECT *,
      parameter <-> ?::vector
      AS l2_distance
      FROM tracks
      ORDER BY l2_distance LIMIT 6;",
      parameter_vector
    ])

    uri = URI.parse("https://itunes.apple.com/lookup")
    uri.query = URI.encode_www_form({
      lang: "ja_jp",
      country: "jp",
      media: "music",
      id: @tracks.map(&:itunes_id).join(',')
    })

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      track_hashes = JSON.parse(response.body)["results"] || []

      @tracks.each do |track|
        track_hash = track_hashes.find { |t| t["trackId"] == track.itunes_id }
        next unless track_hash

        track.title = track_hash["trackName"]
        track.artist = track_hash["artistName"]
        track.image_url = track_hash["artworkUrl100"]
        track.preview_url = track_hash["previewUrl"]
        track.applemusic_url = track_hash["trackViewUrl"]
      end
    else
      binding.break
    end
  end

  private

  def book_params
    params.permit(:query)
  end
end
