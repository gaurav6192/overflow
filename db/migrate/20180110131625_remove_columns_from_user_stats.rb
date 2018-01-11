class RemoveColumnsFromUserStats < ActiveRecord::Migration[5.1]
  def change
  	remove_column :user_stats, :questions_count, :integer
  	remove_column :user_stats, :answers_count, :integer
  end
end
