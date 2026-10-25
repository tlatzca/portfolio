class CreateTracks < ActiveRecord::Migration[8.1]
  def change
    create_table :tracks do |t|
      t.integer :itunes_id, null: false, index: { unique: true }
      t.string :spotify_id
      t.string :genre, null: false
      t.column :parameter, "vector(4)", null: false
      t.column :z_score, "vector(4)"
      t.jsonb :analysis, null: false
      t.timestamps
    end
  end
end
