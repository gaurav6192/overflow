class RemoveUserIdFromUserStats < ActiveRecord::Migration[5.1]
  def change
  	remove_column :user_stats, :user_id, :bigint
  end
end
