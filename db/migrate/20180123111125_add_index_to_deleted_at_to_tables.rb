class AddIndexToDeletedAtToTables < ActiveRecord::Migration[5.1]
  def change
  	tables = [:answer_stats, :answers, :badges, :comment_stats, :comments, :edits, :post_stats, 
  						:posts, :recommendations, :revisions, :sessions, :statuses, :tags, :user_stats, 
  						:users, :vote_types, :votes]

  	tables.each do |table_name|
  		add_index table_name, :deleted_at
	  end
  end
end
