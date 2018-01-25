class Badge < ApplicationRecord
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	
	has_and_belongs_to_many :users

	ignore_deleted
end
