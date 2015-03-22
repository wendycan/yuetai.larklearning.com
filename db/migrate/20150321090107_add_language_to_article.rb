class AddLanguageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :language, :string, default: 'html'
  end
end
