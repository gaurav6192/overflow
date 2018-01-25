class Revision < ApplicationRecord
	validates_presence_of :user
	
	belongs_to :revisionable, polymorphic: true, optional: true
	belongs_to :user

	ignore_deleted
end
