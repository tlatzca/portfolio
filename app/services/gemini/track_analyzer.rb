module Gemini
  class TrackAnalyzer
    def initialize(track_hash)
      @track_hash = track_hash
    end

    def call
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

            ### Step 1: Component Extraction
            Extract key elements for the target track and artist across the following three categories.
            - **Sound**: The specific instrumentation, tone, and what kind of sounds or electronic/acoustic textures are used in the track.
            - **Melody / Progression**: The structural progression, harmonic movement, and rhythmic flow of the melody.
            - **Title / Lyrical Worldview**: The imagery, themes, and worldview suggested by the title and lyrics.

            ### Step 2: Parameter Evaluation
            Evaluate the parameters based on the components extracted in Step 1, following these rules.
            - **Component-specific Evaluation**: Evaluate the energy and weirdness for each component (Sound, Melody, Lyrics) independently based solely on that component's characteristics.
            - **Independence of Axes**: The axes must be evaluated independently without ungrounded correlations (e.g., do not automatically link dark with quiet).
            - **Avoid Middle Values**: Do not default to a safe middle value (40-60); actively push scores toward the higher or lower ends when appropriate.
            - **Strict Factuality**: Do not guess if you lack specific knowledge; reason only within a reasonable range based on the input data.
            - **Track & Artist Priority**: When the target track or artist has well-known, distinctive characteristics or styles, prioritize those specific traits over generic genre-based assumptions.

            ### Step 3: Genre Determination
            Completely independent of the parameter evaluation in Step 2, output exactly one string selected from the list.
            * If you are not confident about the target work or artist, use the provided reference genre as a hint, but still select the closest match from the list based on the work's actual characteristics.

            ---

            [Input Data]
            - Title: #{@track_hash[:title]}
            - Artist: #{@track_hash[:artist]}
            - Album: #{@track_hash[:album]}
            - Genre: #{@track_hash[:genre]}"
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
                    description: "Specific details of the track to be analyzed, excluding artist information."
                  },
                  sound: {
                    type: "object",
                    description: "Analysis of the work's sound and instrumentation.",
                    properties: {
                      reason: {
                        type: "string",
                        description: "Focus ONLY on timbre, instrumentation adn sound loudness. Do NOT mention pitch, melody lines, chord progressions, or musical structure."
                      },
                      energy: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Sound Loudness (0: Quiet, soft ↔ 100: Loud, heavy, powerful sound)"
                      },
                      weirdness: {
                        type: "integer", 
                        minimum: 0, 
                        maximum: 100, 
                        description: "Instrument & Tone Strangeness (0: Standard instruments ↔ 100: Strange, instrument and tones)"
                      }
                    },
                    required: [ "reason", "energy", "weirdness" ]
                  },
                  melody: {
                    type: "object",
                    description: "Analysis of the work's melody and structural progression.",
                    properties: {
                      reason: {
                        type: "string",
                        description: "Focus ONLY on melody lines, chord progressions, time signatures, and structural dynamics. Do NOT mention instrument tones, sound effects, or mixing style."
                      },
                      energy: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Melody & Progression Intensity / Dynamic drive (0: Static, smooth, calm ↔ 100: Highly dynamic, intense, aggressive progression)"
                      },
                      weirdness: {
                        type: "integer", 
                        minimum: 0, 
                        maximum: 100, 
                        description: "Structural & Melodic Strangeness (0: Conventional, standard arrangement ↔ 100: Unusual, unpredictable, or avant-garde structure and melody)"
                      }
                    },
                    required: [ "reason", "energy", "weirdness" ]
                  },
                  lyrics_worldview: {
                    type: "object",
                    description: "Analysis of the work's title and lyrical worldview.",
                    properties: {
                      reason: {
                        type: "string",
                        description: "Focus ONLY on the literal meaning of lyrics, track title, album title, thematic concepts, narrative perspective, and emotional/philosophical worldview. Do NOT mention instrumentation, musical arrangement, or audio characteristics."
                      },
                      energy: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Lyrical / Worldview Intensity (0: Calm, passive, quiet themes ↔ 100: Aggressive, high-tension, powerful themes)"
                      },
                      weirdness: {
                        type: "integer",
                        minimum: 0,
                        maximum: 100,
                        description: "Worldview Strangeness / Absurdity (0: Realistic, conventional, logical ↔ 100: Absurd, surreal, deeply bizarre worldview)"
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
                    description: "Analysis of the work's overall organic/natural texture, based primarily on the sound component (0: Electronic, synthesized sound ↔ 100: Acoustic instruments, natural depiction).",
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
                required: [ "target_name", "sound", "melody", "lyrics_worldview", "valence", "acousticness", "genre_reason", "genre" ]
              }
            }
          }
        }
      }.to_json

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      return nil unless response.is_a?(Net::HTTPSuccess)

      parameter_text = JSON.parse(response.body).dig("candidates", 0, "content", "parts", 0, "text")
      JSON.parse(parameter_text)
    end
  end
end