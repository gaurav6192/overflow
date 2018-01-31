class AddColumnToEdits < ActiveRecord::Migration[5.1]
  def change
    add_column :edits, :score, :integer, default: 0, null: false
  end
end
