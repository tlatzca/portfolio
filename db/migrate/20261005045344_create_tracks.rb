class CreateTracks < ActiveRecord::Migration[8.1]
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.string :artist, null: false
      t.string :itunes_id, null: false, index: { unique: true }
      t.string :genre, null: false
      t.date :release_date
      t.string :image_url
      t.string :preview_url
      t.string :spotify_url
      t.string :applemusic_url
      t.float :valence, null: false
      t.float :energy, null: false
      t.float :acousticness, null: false
      t.float :weirdness, null: false
      t.timestamps
    end
  end
end
