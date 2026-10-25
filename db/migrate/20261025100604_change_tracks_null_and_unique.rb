class ChangeTracksNullAndUnique < ActiveRecord::Migration[8.1]
  def change
    change_column_null :tracks, :title, false
    change_column_null :tracks, :artist, false
    remove_index :tracks, :itunes_id
    add_index :tracks, :itunes_id, unique: true
  end
end
