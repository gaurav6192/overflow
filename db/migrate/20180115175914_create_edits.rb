class CreateEdits < ActiveRecord::Migration[5.1]
  def change
    create_table :edits do |t|
      t.jsonb :editable_content, null: false, default: '{}'

      t.references :editable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
