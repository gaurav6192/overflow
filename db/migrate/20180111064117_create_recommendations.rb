class CreateRecommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendations do |t|
      t.integer :score
      t.belongs_to :post, index: true, foreign_key: true
      t.timestamps
    end
  end
end
