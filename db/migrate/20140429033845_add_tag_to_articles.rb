class AddTagToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :utag, :string
  end
end
