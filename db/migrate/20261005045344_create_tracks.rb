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
      t.jsonb :details, null: false
      t.column :parameter, "vector(4)", null: false
      t.timestamps
    end
  end
end
