class CreateAnswerStats < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_stats do |t|
      t.integer :score
      t.integer :view_count
      t.datetime :last_activity_date
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
