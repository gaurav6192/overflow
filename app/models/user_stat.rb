class UserStat < ApplicationRecord
	ignore_deleted
	voteable
	
	validates_presence_of :reputation_count, :user

	belongs_to :user
end
