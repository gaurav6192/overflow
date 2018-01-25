class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :vote_type, foreign_key: true
      t.references :user_stat, foreign_key: true

      t.references :voteable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
