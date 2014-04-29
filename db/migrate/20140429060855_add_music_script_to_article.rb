class AddMusicScriptToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :music_script, :text
  end
end
