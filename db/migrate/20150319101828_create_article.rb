class CreateArticle < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text   :body
      t.string :template
      t.integer :user_id
      t.string :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
