class AddColumnToRecommendations < ActiveRecord::Migration[5.1]
  def change
    add_column :recommendations, :recommendation_id, :bigint
    add_index :recommendations, :recommendation_id
    add_foreign_key :recommendations, :posts, column: :recommendation_id, primary_key: :id
  end
end
