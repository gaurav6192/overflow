class AddReferenceToRevision < ActiveRecord::Migration[5.1]
  def change
    add_reference :revisions, :edit, foreign_key: true
  end
end
