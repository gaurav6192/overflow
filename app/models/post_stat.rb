class PostStat < ApplicationRecord
	validates_presence_of :score, :view_count, :post

  belongs_to :post

  ignore_deleted
  voteable
end
