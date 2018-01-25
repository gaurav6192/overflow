class Edit < ApplicationRecord
	validates_presence_of :user

	belongs_to :editable, polymorphic: true, optional: true
	belongs_to :user

	ignore_deleted
end
