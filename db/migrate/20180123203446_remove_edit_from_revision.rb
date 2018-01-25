class RemoveEditFromRevision < ActiveRecord::Migration[5.1]
  def change
    remove_reference :revisions, :edit, foreign_key: true
  end
end
