class TracksController < ApplicationController
  require "net/http"
  require "uri"

  def index
    uri = URI.parse("https://itunes.apple.com/search")
    uri.query = URI.encode_www_form({
      lang: "ja_jp",
      country: "jp",
      limit: 1,
      media: "music",
      term: track_params[:query]
    })

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      track = JSON.parse(response.body)["results"][0]
    else
      track = []
    end

    uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:generateContent")
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["X-goog-api-key"] = ENV["GEMINI_API_KEY"]
    request.body = {
      contents: [ {
        parts: [
          { text:
          "You are an expert who analyzes the atmosphere of a music and quantifies it using four parameters.

          Synthesize the provided input data and your knowledge of the target work to analyze and evaluate the work's atmosphere according to the following rules.

          ### 1. Extraction of Components
          For the target work, extract elements related to the following three categories,
          Categories: Sound, Melody/Progression, Title/Lyrical Worldview

          ### 2. Parameter Evaluation per Component
          For each of the three extracted components, evaluate the following four axis parameters individually as integer values from 0 to 100.
          * The four axes must be evaluated independently, without influencing one another (e.g., automatic correlations such as dark = quiet or intense = high tension are prohibited).
          * The components must be evaluated independently of one another, based solely on the characteristics specific to each component (e.g., even if the Sound's energy is high, if the Melody is calm, the Melody's energy should be rated low).
          * Do not default to a safe middle value (40-60). Actively push each axis score toward the higher or lower end.
          * If you lack specific knowledge about the target work, do not supplement details with guesswork; reason only within a reasonable range based solely on the given input data.

          - valence (Brightness / Positivity)
            0: tragic, melancholic ↔ 100: Cheerful, hopeful

          - energy (Intensity / Power)
            0: Static, calm, low stimulation ↔ 100: Intense, high-pressure, powerful

          - acousticness (Organic / Natural texture)
            0: Electronic, digital, mechanical ↔ 100: Live instruments, natural depiction, Lived-in

          - weirdness (Strangeness / Absurdity)
            0: Conventional, logical ↔ 100: Strange, absurd, surreal

          ### 3. Genre Determination
          Completely independent of the parameter evaluation in Step 2, output exactly one string selected from the list.
          * When selecting the genre, prioritize information specific to the target work itself over information about the artist.
          * If you are not confident about the target work or artist, use the provided reference genre as a hint, but still select the closest match from the list based on the work's actual characteristics.

          ---

          [Input Data]
          - Title: #{track["trackName"]}
          - Artist: #{track["artistName"]}
          - Album: #{track["collectionName"]}
          - Release Date: #{track["releaseDate"]}
          - Genre: #{track["primaryGenreName"]}"
          }
        ]
      } ],
      generationConfig: {
        temperature: 0,
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
                sound: {
                  type: "object",
                  description: "Analysis of the work's sound and instrumentation.",
                  properties: {
                    reason: { type: "string", description: "The specific characteristics that justify the parameter values below." },
                    valence: { type: "integer", minimum: 0, maximum: 100 },
                    energy: { type: "integer", minimum: 0, maximum: 100 },
                    acousticness: { type: "integer", minimum: 0, maximum: 100 },
                    weirdness: { type: "integer", minimum: 0, maximum: 100 }
                  },
                  required: [ "reason", "valence", "energy", "acousticness", "weirdness" ]
                },
                melody: {
                  type: "object",
                  description: "Analysis of the work's melody and structural progression.",
                  properties: {
                    reason: { type: "string", description: "The specific characteristics that justify the parameter values below." },
                    valence: { type: "integer", minimum: 0, maximum: 100 },
                    energy: { type: "integer", minimum: 0, maximum: 100 },
                    acousticness: { type: "integer", minimum: 0, maximum: 100 },
                    weirdness: { type: "integer", minimum: 0, maximum: 100 }
                  },
                  required: [ "reason", "valence", "energy", "acousticness", "weirdness" ]
                },
                lyrics_worldview: {
                  type: "object",
                  description: "Analysis of the work's title and lyrical worldview.",
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
                    "Pop Rock",
                    "Emo / Math Rock",
                    "Hard Rock / Metal",
                    "Electronic Pop",
                    "Electronica",
                    "Folk / Acoustic",
                    "Classical / Jazz",
                    "Hip-Hop / R&B"
                  ],
                  description: "The selected genre, chosen from the predefined list."
                }
              },
              required: [ "target_name", "sound", "melody", "lyrics_worldview", "genre_reason", "genre" ]
            }
          }
        }
      }
    }.to_json

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    if response.is_a?(Net::HTTPSuccess)
      result_text = JSON.parse(response.body)["candidates"][0]["content"]["parts"][0]["text"]
      parameter =  JSON.parse(result_text)
    else
      parameter = []
    end
    
    valence_array = [
      parameter["sound"]["valence"],
      parameter["melody"]["valence"],
      parameter["lyrics_worldview"]["valence"]
    ] 
    valence_average = valence_array.sum.fdiv(valence_array.size)
    valence = valence_average / 100

    energy_array = [
      parameter["sound"]["energy"],
      parameter["melody"]["energy"],
      parameter["lyrics_worldview"]["energy"]
    ] 
    energy_average = energy_array.sum.fdiv(energy_array.size)
    energy = energy_average / 100

    acousticness_array = [
      parameter["sound"]["acousticness"],
      parameter["melody"]["acousticness"],
      parameter["lyrics_worldview"]["acousticness"]
    ] 
    acousticness_average = acousticness_array.sum.fdiv(acousticness_array.size)
    acousticness = acousticness_average / 100

    weirdness_array = [
      parameter["sound"]["weirdness"],
      parameter["melody"]["weirdness"],
      parameter["lyrics_worldview"]["weirdness"]
    ]
    weirdness_average = weirdness_array.sum.fdiv(weirdness_array.size)
    weirdness = weirdness_average / 100

    parameter_array = [valence, energy, acousticness, weirdness]
    parameter_vector = "[#{parameter_array.join(',')}]"
  end

  private

  def track_params
    params.permit(:query)
  end
end
