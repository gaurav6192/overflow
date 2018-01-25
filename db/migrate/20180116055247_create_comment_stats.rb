class CreateCommentStats < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_stats do |t|
      t.integer :score
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
