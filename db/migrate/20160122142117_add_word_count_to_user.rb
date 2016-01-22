class AddWordCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :words_count, :integer, default: 0
  end
end
