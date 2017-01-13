class ChangeNoteType < ActiveRecord::Migration
  def change
    rename_column :notes, :type, :content_type
  end
end
