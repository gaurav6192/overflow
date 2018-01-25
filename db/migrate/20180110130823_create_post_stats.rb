class CreatePostStats < ActiveRecord::Migration[5.1]
  def change
    create_table :post_stats do |t|
      t.integer :score
      t.integer :view_count
      t.datetime :last_activity_date
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
