class AddVectorToTracksAndNovels < ActiveRecord::Migration[8.1]
  def change
    add_column :tracks, :parameter_vector, :vector, limit:4
    add_column :novels, :parameter_vector, :vector, limit:4
  end
end
