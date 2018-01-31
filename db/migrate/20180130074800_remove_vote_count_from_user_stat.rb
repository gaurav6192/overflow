class RemoveVoteCountFromUserStat < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_stats, :vote_count, :integer
  end
end
