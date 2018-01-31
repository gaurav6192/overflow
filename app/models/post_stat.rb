class PostStat < ApplicationRecord
  ignore_deleted
  voteable
	
	validates_presence_of :score, :view_count, :post

  belongs_to :post
end
