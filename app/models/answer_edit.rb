class AnswerEdit < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  has_many :comments, as: :commentable
  has_many :statuses, as: :statusable
end
