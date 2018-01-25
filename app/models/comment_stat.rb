class CommentStat < ApplicationRecord
	validates_presence_of :score, :comment
  
  belongs_to :comment

  ignore_deleted
  voteable
end
