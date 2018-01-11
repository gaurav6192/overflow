class CreateVoteTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :vote_types do |t|
      t.string :title, null: false
      t.integer :score_change, null: false

      t.timestamps
    end
  end
end
