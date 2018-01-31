class Tag < ApplicationRecord
  ignore_deleted
	
	validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :posts
  has_and_belongs_to_many :users
end
