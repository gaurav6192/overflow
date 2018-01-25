class ChangeUserIdTypeInUserStats < ActiveRecord::Migration[5.1]
  def up
  	change_column :user_stats, :user_id, :bigint
  end

  def down
  	change_column :user_stats, :user_id, :integer
  end
end
