class VoteType < ApplicationRecord
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :score_change, presence: true

	has_many :votes
end
