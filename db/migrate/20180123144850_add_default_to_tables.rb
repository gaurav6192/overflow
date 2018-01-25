class AddDefaultToTables < ActiveRecord::Migration[5.1]
  def change
  	change_column :answer_stats, :score, :integer, default: 0, null: false
  	change_column :answer_stats, :view_count, :integer, default: 0, null: false
  	change_column :comment_stats, :score, :integer, default: 0, null: false
  	change_column :post_stats, :score, :integer, default: 0, null: false
  	change_column :post_stats, :view_count, :integer, default: 0, null: false
  	change_column :recommendations, :score, :integer, default: 0, null: false
  	change_column :user_stats, :reputation_count, :integer, default: 0, null: false
  	change_column :user_stats, :vote_count, :integer, default: 0, null: false
  end
end
