class CreateEditStats < ActiveRecord::Migration[5.1]
  def change
    create_table :edit_stats do |t|
      t.references :edit, foreign_key: true
      t.integer :score, default: 0, null: false
      t.datetime :last_activity_date

      t.timestamps
    end
  end
end
