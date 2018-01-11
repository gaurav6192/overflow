class RemoveColumnFromComments < ActiveRecord::Migration[5.1]
  def change
  	remove_column :comments, :content, :text
  end
end
