class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notebook_email_to, :string
    add_column :users, :notebook_email_to_password, :string
    add_column :users, :notebook_email_from, :string
  end
end
