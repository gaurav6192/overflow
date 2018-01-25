class UserStat < ApplicationRecord
	validates_presence_of :reputation_count, :vote_count, :user

	belongs_to :user
	
	ignore_deleted
	voteable
end
