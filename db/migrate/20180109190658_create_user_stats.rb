class CreateUserStats < ActiveRecord::Migration[5.1]
  def change
    create_table :user_stats do |t|
      t.integer :questions_count, default: 0
      t.integer :answers_count, default: 0

      t.timestamps
    end
  end
end
