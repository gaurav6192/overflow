class VoteType < ApplicationRecord
	ignore_deleted
	
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates_presence_of :score_change

	has_many :votes
end
