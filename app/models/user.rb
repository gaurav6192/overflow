class User < ApplicationRecord
	# TODO : Add more validations to fields
	before_save { email.downcase! }

	has_one :user_stat
	has_many :posts
	has_many :post_edits
	has_many :comments
	has_many :comment_edits
	has_many :answers
	has_many :answer_edits
	has_and_belongs_to_many :badges
	has_and_belongs_to_many :tags


	has_secure_password

	validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
	validates :full_name, presence: true, length: { maximum: 50 }
	validates :user_name, presence: true, length: { maximum: 20 }
	validates :password, presence: true
	validates :password_confirmation, presence: true
end