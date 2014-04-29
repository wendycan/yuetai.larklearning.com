class AddAuthorToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :uauthor, :string
  end
end
