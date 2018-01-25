class ChangeColumnTitleToNameForVoteTypes < ActiveRecord::Migration[5.1]
  def up
  	rename_column :vote_types, :title, :name
  end

  def down
  	rename_column :vote_types, :name, :title
  end
end
