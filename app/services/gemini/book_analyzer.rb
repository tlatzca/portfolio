module Gemini
  class BookAnalyzer
    def initialize(book_hash)
      @book_hash = book_hash
    end

    def call
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

            ### Step 1: Component Extraction
            Extract key elements for the target work and author across the following three categories.
            - **Story Progression / Plot**: The structural progression, plot development, and pacing of the narrative.
            - **Prose Style / Tone**: The tone, literary voice, and stylistic features of the writing.
            - **Worldview / Setting**: The atmosphere, thematic elements, and setting suggested by the title and background.

            ### Step 2: Parameter Evaluation
            Evaluate the parameters based on the components extracted in Step 1, following these rules.
            - **Component-specific Evaluation**: Evaluate the energy and weirdness for each component (Story Progression, Prose Style, Worldview) independently based solely on that component's characteristics.
            - **Independence of Axes**: The axes must be evaluated independently without ungrounded correlations (e.g., do not automatically link dark with quiet).
            - **Avoid Middle Values**: Do not default to a safe middle value (40-60); actively push scores toward the higher or lower ends when appropriate.
            - **Strict Factuality**: Do not guess if you lack specific knowledge; reason only within a reasonable range based on the input data.
            - **Work & Author Priority**: When the target work or author has well-known, distinctive characteristics or styles, prioritize those specific traits over generic genre-based assumptions.

            ### Step 3: Genre Determination
            Completely independent of the parameter evaluation in Step 2, output exactly one string selected from the list.
            * If you are not confident about the target work or author, use the provided reference genre as a hint, but still select the closest match from the list based on the work's actual characteristics.

            ---

            [Input Data]
            - Title: #{@book_hash[:title]}
            - Author: #{@book_hash[:author]}
            - Caption: #{@book_hash[:caption]}"
            }
          ]
        } ],
        generationConfig: {
          temperature: 0,
          seed: 497,
          responseFormat: {
            text: {
              mimeType: "APPLICATION_JSON",
              schema: {
                type: "object",
                properties: {
                  target_name: {
                    type: "string",
                    description: "Specific details of the book to be analyzed, excluding author information."
                  },
                  story_progression: {
                    type: "object",
                    description: "Analysis of the work's plot development and pacing.",
                    properties: {
                      reason: {
                        type: "string",
                        description: "Focus ONLY on plot development, story pacing, and structural dynamics. Do NOT mention writing tone, word choice, or setting details."
                      },
                      energy: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Plot & Story Intensity / Dynamic drive (0: Static, slow-paced, calm ↔ 100: Highly dynamic, intense, fast-paced plot)"
                      },
                      weirdness: {
                        type: "integer", 
                        minimum: 0, 
                        maximum: 100, 
                        description: "Structural & Plot Strangeness (0: Conventional, standard narrative structure ↔ 100: Unusual, unpredictable, or avant-garde plot development)"
                      }
                    },
                    required: [ "reason", "energy", "weirdness" ]
                  },
                  prose_style: {
                    type: "object",
                    description: "Analysis of the work's writing style, voice, and tone.",
                    properties: {
                      reason: {
                        type: "string",
                        description: "Focus ONLY on writing style, literary tone, sentence rhythm, and vocabulary. Do NOT mention overall plot twists or atmospheric worldview settings."
                      },
                      energy: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Prose & Tone Intensity (0: Calm, passive, gentle prose ↔ 100: Energetic, passionate, high-tension writing style)"
                      },
                      weirdness: {
                        type: "integer", 
                        minimum: 0, 
                        maximum: 100, 
                        description: "Stylistic & Expression Strangeness (0: Standard, straightforward grammar and tone ↔ 100: Highly unusual, experimental, or distinctive prose style)"
                      }
                    },
                    required: [ "reason", "energy", "weirdness" ]
                  },
                  worldview: {
                    type: "object",
                    description: "Analysis of the story's setting and the overall mood/atmosphere of that world.",
                    properties: {
                      reason: {
                        type: "string",
                        description: "Focus ONLY on the setting, background atmosphere, thematic concepts, and underlying worldview. Do NOT mention writing style or plot pacing."
                      },
                      energy: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Worldview / Atmosphere Intensity (0: Calm, quiet, peaceful environment ↔ 100: Chaotic, high-tension, hostile environment)"
                      },
                      weirdness: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Worldview Strangeness / Absurdity (0: Realistic, conventional, logical world ↔ 100: Absurd, surreal, deeply bizarre setting)"
                      }
                    },
                    required: [ "reason", "energy", "weirdness" ]
                  },
                  valence: {
                    type: "object",
                    description: "Analysis of the work's overall brightness/positivity (0: tragic, melancholic ↔ 100: Cheerful, hopeful).",
                    properties: {
                      reason: { type: "string", description: "The specific characteristics that justify the value below." },
                      value: { type: "integer", minimum: 0, maximum: 100 }
                    },
                    required: [ "reason", "value" ]
                  },
                  acousticness: {
                    type: "object",
                    description: "Analysis of the work's overall organic/natural texture, based primarily on the worldview component (0: Digital, mechanical, futuristic ↔ 100: Organic, natural depiction, realistic human/nature context).",
                    properties: {
                      reason: { type: "string", description: "The specific characteristics that justify the value below." },
                      value: { type: "integer", minimum: 0, maximum: 100 }
                    },
                    required: [ "reason", "value" ]
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
                required: [ "target_name", "story_progression", "prose_style", "worldview", "valence", "acousticness", "genre_reason", "genre" ]
              }
            }
          }
        }
      }.to_json

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      return nil unless response.is_a?(Net::HTTPSuccess)

      result_text = JSON.parse(response.body).dig("candidates", 0, "content", "parts", 0, "text") || []
      JSON.parse(result_text)
    end
  end
end