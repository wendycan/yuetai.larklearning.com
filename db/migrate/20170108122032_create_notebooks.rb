class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :title
      t.text :notes
      t.string :citation
      t.string :authors
      t.integer :user_id

      t.timestamps
    end
  end
end
