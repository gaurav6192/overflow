class AddAboutToBadges < ActiveRecord::Migration[5.1]
  def change
    add_column :badges, :about, :text
  end
end
