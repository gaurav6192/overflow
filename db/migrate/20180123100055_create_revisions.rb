class CreateRevisions < ActiveRecord::Migration[5.1]
  def change
    create_table :revisions do |t|
      t.jsonb :revisionable_content, null: false, default: '{}'

      t.references :revisionable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
