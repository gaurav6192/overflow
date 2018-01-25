class AddValidationToUsers < ActiveRecord::Migration[5.1]
  def up
  	change_column :users, :full_name, :string, null: false
  	change_column :users, :user_name, :string, null: false
  	change_column :users, :email, :string, null: false
	end

	def down
		change_column :users, :full_name, :string
  	change_column :users, :user_name, :string
  	change_column :users, :email, :string
	end
end
