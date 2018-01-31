class AnswerStat < ApplicationRecord  
  ignore_deleted
  voteable

	validates_presence_of :score, :view_count, :answer
  
  belongs_to :answer
end
