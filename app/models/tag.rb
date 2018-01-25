class Tag < ApplicationRecord
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates_presence_of :user

  belongs_to :user

  has_and_belongs_to_many :posts
  has_and_belongs_to_many :users

  ignore_deleted
end
