class CreateAnswerEdits < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_edits do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
