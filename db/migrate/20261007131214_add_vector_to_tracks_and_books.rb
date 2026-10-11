class AddVectorToTracksAndBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :tracks, :parameter_vector, :vector, limit: 4
    add_column :books, :parameter_vector, :vector, limit: 4
  end
end
