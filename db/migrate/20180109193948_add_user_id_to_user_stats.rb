class AddUserIdToUserStats < ActiveRecord::Migration[5.1]
  def change
    add_column :user_stats, :user_id, :integer
  end
end
