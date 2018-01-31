class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	has_secure_password
	ignore_deleted

	validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false },
										format: { with: VALID_EMAIL_REGEX }
	validates :full_name, presence: true, length: { maximum: 100 }
	validates :user_name, presence: true, length: { maximum: 50 }, 
												uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	has_one :user_stat, dependent: :destroy
	has_many :posts
	has_many :answers
	has_many :comments
	has_many :revisions
	has_many :sessions, dependent: :destroy
	has_many :votes
	has_and_belongs_to_many :badges
	has_and_belongs_to_many :tags

	before_save { self.email.downcase! }
end