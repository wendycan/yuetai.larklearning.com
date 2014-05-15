class CreateChaps < ActiveRecord::Migration
  def change
    create_table :chaps do |t|
      t.string :name
      t.integer :book_id

      t.timestamps
    end
  end
end
