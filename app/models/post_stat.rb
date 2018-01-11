class PostStat < ApplicationRecord
  belongs_to :post

  has_many :votes, as: :voteable
end
