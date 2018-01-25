class AnswerStat < ApplicationRecord  
	validates_presence_of :score, :view_count, :answer
  
  belongs_to :answer

  ignore_deleted
  voteable
end
