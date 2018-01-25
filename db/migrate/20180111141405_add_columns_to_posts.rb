class AddColumnsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :title, :text
    add_column :posts, :body, :text
  end
end
