class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :location
      t.string :chapter
      t.string :section
      t.string :type
      t.string :color_type
      t.text :content
      t.text :note
      t.integer :notebook_id
      t.integer :user_id

      t.timestamps
    end
  end
end
