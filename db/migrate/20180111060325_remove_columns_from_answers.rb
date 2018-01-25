class RemoveColumnsFromAnswers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :answers, :body, :text
  end
end
