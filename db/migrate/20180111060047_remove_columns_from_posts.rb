class RemoveColumnsFromPosts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :posts, :title, :text
  	remove_column :posts, :body, :text
  end
end
