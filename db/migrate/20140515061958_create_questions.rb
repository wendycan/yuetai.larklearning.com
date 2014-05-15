class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :user_id
      t.integer :chap_id
      t.text :body

      t.timestamps
    end
  end
end
