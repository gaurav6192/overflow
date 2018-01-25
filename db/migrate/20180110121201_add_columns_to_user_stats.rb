class AddColumnsToUserStats < ActiveRecord::Migration[5.1]
  def change
  	add_column :user_stats, :reputation_count, :integer, default: 0
  	add_column :user_stats, :vote_count, :integer, default: 0

  	add_column :user_stats, :last_voted_at, :datetime
  	add_column :user_stats, :last_reputation_changed_at, :datetime
  end
end
