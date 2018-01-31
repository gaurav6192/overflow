class EditStat < ApplicationRecord  
  ignore_deleted
  voteable

	validates_presence_of :score, :edit
  
  belongs_to :edit
end
