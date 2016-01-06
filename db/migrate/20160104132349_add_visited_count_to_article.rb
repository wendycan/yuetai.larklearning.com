class AddVisitedCountToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :visited_count, :integer, default: '0'
  end
end
