class CreateExcerpts < ActiveRecord::Migration
  def change
    create_table :excerpts do |t|
      t.text :body
      t.integer :likes_count
      t.integer :unlikes_count
      t.integer :normals_count
      t.integer :chap_id

      t.timestamps
    end
  end
end
