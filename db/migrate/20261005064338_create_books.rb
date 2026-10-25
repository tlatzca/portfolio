class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :isbn, null: false, index: { unique: true }
      t.string :genre, null: false
      t.column :parameter, "vector(4)", null: false
      t.column :z_score, "vector(4)"
      t.jsonb :analysis, null: false
      t.timestamps
    end
  end
end
