class CommentStat < ApplicationRecord
  ignore_deleted
  voteable
	
	validates_presence_of :score, :comment
  
  belongs_to :comment
end
