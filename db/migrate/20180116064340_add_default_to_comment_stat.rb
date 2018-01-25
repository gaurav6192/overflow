class AddDefaultToCommentStat < ActiveRecord::Migration[5.1]
  def up
  	change_column :comment_stats, :score, :integer, default: 0
  end

  def down
  	change_column :comment_stats, :score, :integer
  end
end
