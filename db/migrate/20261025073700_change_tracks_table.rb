class ChangeTracksTable < ActiveRecord::Migration[8.1]
  def change
    add_column :tracks, :title, :string
    add_column :tracks, :artist, :string
    change_column :tracks, :itunes_id, :bigint, null: false
  end
end
