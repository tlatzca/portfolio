class BooksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    uri = URI.parse("https://openapi.rakuten.co.jp/services/api/BooksTotal/Search/20170404")

    uri.query = URI.encode_www_form({
      format: "json",
      keyword: book_params[:query],
      applicationId: ENV["RAKUTEN_API_ID"],
      accessKey: ENV["RAKUTEN_API_KEY"]
    })

    request = Net::HTTP::Get.new(uri)
    request["Referer"] = "https://myapp-ih54.onrender.com/"
    request["Origin"] = "https://myapp-ih54.onrender.com/"

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      results = JSON.parse(response.body)["Items"]
    else
      results = []
    end
    
    book = results.find do |result|
      result["Item"]["author"].present? &&
      result["Item"]["itemCaption"].present?
    end

    book ||= results.find do |result|
      result["Item"]["author"].present?
    end
    
    uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:generateContent")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["X-goog-api-key"] = ENV["GEMINI_API_KEY"]
    request.body = {
      contents: [{
        parts:[
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
          - Title: #{book["Item"]["title"]}
          - Auhor: #{book["Item"]["author"]}
          - Caption: #{book["Item"]["itemCaption"]}
          - Release Date: #{book["Item"]["salesDate"]}"
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
                  required: ["reason", "valence", "energy", "acousticness", "weirdness"]
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
                  required: ["reason", "valence", "energy", "acousticness", "weirdness"]
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
                  required: ["reason", "valence", "energy", "acousticness", "weirdness"]
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
              required: ["target_name", "story_progression", "prose_style", "worldview", "genre_reason", "genre"]
            }
          }
        }
      }
    }.to_json
    
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    
    if response.is_a?(Net::HTTPSuccess)
      @parameter = JSON.parse(response.body)
    else
      @parameter = []
    end
  end

  private

  def book_params
    params.permit(:query)
  end
end
