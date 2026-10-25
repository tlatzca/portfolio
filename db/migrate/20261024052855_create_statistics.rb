class CreateStatistics < ActiveRecord::Migration[8.1]
  def change
    create_table :statistics do |t|
        t.string :media_type, null: false
        t.float :valence_average, null: false
        t.float :valence_stddev, null: false
        t.float :energy_average, null: false
        t.float :energy_stddev, null: false
        t.float :acousticness_average, null: false
        t.float :acousticness_stddev, null: false
        t.float :weirdness_average, null: false
        t.float :weirdness_stddev, null: false
      t.timestamps
    end
  end
end
