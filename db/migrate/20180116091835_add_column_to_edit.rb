class AddColumnToEdit < ActiveRecord::Migration[5.1]
  def change
    add_reference :edits, :user, foreign_key: true
  end
end
