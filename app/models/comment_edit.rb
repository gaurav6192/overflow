class CommentEdit < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  has_many :statuses, as: :statusable
end
