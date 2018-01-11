class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :answer_stat
  has_many :answer_edits
  has_many :statuses, as: :statusable
end
