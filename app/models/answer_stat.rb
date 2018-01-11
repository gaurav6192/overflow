class AnswerStat < ApplicationRecord  
  belongs_to :answer

  has_many :votes, as: :voteable
end
