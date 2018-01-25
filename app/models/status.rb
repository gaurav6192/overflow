class Status < ApplicationRecord
	validates_presence_of :name, :user

	belongs_to :statusable, polymorphic: true, optional: true
	belongs_to :user

	has_many :posts, -> { where(deleted_at: nil) }, dependent: :destroy
	has_many :answers, -> { where(deleted_at: nil) }, dependent: :destroy

	ignore_deleted
end
