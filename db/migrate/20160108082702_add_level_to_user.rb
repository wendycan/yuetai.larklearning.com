class AddLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :level, :integer, default: '0'
  end
end
