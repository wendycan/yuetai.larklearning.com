class AddBookIdToExcerpts < ActiveRecord::Migration
  def change
    add_column :excerpts, :book_id, :integer
  end
end
