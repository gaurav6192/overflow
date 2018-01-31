class RemoveUserFromTags < ActiveRecord::Migration[5.1]
  def change
    remove_reference :tags, :user, foreign_key: true
  end
end
