class AddAuthorIdToExcerpt < ActiveRecord::Migration
  def change
    add_column :excerpts, :author_id, :integer
    remove_column :excerpts, :user_id
  end
end
