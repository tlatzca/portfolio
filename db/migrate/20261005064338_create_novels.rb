class CreateNovels < ActiveRecord::Migration[8.1]
  def change
    create_table :novels do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :isbn, null: false, index: { unique: true }
      t.string :genre, null: false
      t.text :caption
      t.date :release_date
      t.string :image_url
      t.float :valence, null: false
      t.float :energy, null: false
      t.float :acousticness, null: false
      t.float :weirdness, null: false
      t.timestamps
    end
  end
end
