class UserStat < ApplicationRecord
	validates :reputation_count, presence: true
	validates :vote_count, presence: true
	validates :user_id, presence: true

	belongs_to :user
	has_many :votes, as: :voteable
end
