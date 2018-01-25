class AddValidationForNameToBadges < ActiveRecord::Migration[5.1]
  def change
  	change_column :badges, :name, :string, unique: true, null: false
  end
end
