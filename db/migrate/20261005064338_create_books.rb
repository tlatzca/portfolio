class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn, null: false, index: { unique: true }
      t.string :genre, null: false
      t.text :caption
      t.date :release_date
      t.string :image_url
      t.jsonb :details, null: false
      t.column :parameter, "vector(4)", null: false
      t.timestamps
    end
  end
end
