class AddDescToUser < ActiveRecord::Migration
  def change
    add_column :users, :desc, :text, default: ''
    add_column :users, :github, :string, default: ''
    add_column :users, :webchat, :string, default: ''
    add_column :users, :avator, :string, default: ''
  end
end
