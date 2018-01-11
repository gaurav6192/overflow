class CreatePostEdits < ActiveRecord::Migration[5.1]
  def change
    create_table :post_edits do |t|
      t.text :title
      t.text :body
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
