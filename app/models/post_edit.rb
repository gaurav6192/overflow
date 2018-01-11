class PostEdit < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :comments, as: :commentable
  has_many :statuses, as: :statusable
end
