class AddDeletedAtToEditStat < ActiveRecord::Migration[5.1]
  def change
    add_column :edit_stats, :deleted_at, :datetime
    add_index :edit_stats, :deleted_at
  end
end
