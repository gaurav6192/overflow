class AddUserRefToUserStats < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_stats, :user, foreign_key: true
  end
end
