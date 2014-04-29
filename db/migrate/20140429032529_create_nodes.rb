class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
