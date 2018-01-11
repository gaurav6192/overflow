class CreateCommentEdits < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_edits do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
