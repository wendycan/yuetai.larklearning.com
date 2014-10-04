class AddQuoteToExcerpts < ActiveRecord::Migration
  def change
    add_column :excerpts, :quote, :text
  end
end
