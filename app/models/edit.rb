class Edit < ApplicationRecord
	ignore_deleted
	
	validates_presence_of :user, :editable_content, :score

	belongs_to :editable, polymorphic: true, optional: true
	belongs_to :user
	has_one :revision
	has_one :answer_stat, dependent: :destroy
end
