# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_05_064338) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "novels", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.string "isbn", null: false
    t.string "genre", null: false
    t.text "caption"
    t.date "release_date"
    t.string "image_url"
    t.float "valence", null: false
    t.float "energy", null: false
    t.float "acousticness", null: false
    t.float "weirdness", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["isbn"], name: "index_novels_on_isbn", unique: true
  end

  create_table "tracks", force: :cascade do |t|
    t.string "title", null: false
    t.string "artist", null: false
    t.string "itunes_id", null: false
    t.string "genre", null: false
    t.date "release_date"
    t.string "image_url"
    t.string "preview_url"
    t.string "spotify_url"
    t.string "applemusic_url"
    t.float "valence", null: false
    t.float "energy", null: false
    t.float "acousticness", null: false
    t.float "weirdness", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itunes_id"], name: "index_tracks_on_itunes_id", unique: true
  end
end
