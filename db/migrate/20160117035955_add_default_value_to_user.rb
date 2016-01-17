class AddDefaultValueToUser < ActiveRecord::Migration
  def change
    change_column :users, :github, :string, default: 'https://github.com/'
    change_column :users, :webchat, :string, default: 'http://g0.ftp.larklearning.com/yuetai/images/default_user_webchat.png'
    change_column :users, :avator, :string, default: 'http://g0.ftp.larklearning.com/yuetai/images/default_user_avator.png'

    remove_columns :users, :editable
  end
end
