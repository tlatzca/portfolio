class ChangeBooksNull < ActiveRecord::Migration[8.1]
  def change
    change_column_null :books, :title, false
    change_column_null :books, :author, false
  end
end
