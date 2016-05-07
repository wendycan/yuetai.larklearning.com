class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :article_id
      t.integer :user_id
      t.integer :liked_count, default: 0

      t.timestamps
    end
  end
end
