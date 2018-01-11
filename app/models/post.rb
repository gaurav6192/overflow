class Post < ApplicationRecord
  belongs_to :user
  
  has_one :post_stat
  has_many :post_edits
  has_many :answers
  has_many :statuses, as: :statusable
  has_and_belongs_to_many :tags
end
