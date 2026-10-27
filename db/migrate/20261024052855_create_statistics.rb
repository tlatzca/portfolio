class CreateStatistics < ActiveRecord::Migration[8.1]
  def change
    create_table :statistics do |t|
        t.string :media_type, null: false
        t.float :average, array: true, null: false
        t.float :stddev, array: true, null: false
      t.timestamps
    end
  end
end
