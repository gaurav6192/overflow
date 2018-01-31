class Revision < ApplicationRecord
	ignore_deleted
	
	validates_presence_of :user, :revisionable_content
	
	belongs_to :revisionable, polymorphic: true, optional: true
	belongs_to :edit, optional: true
	belongs_to :user
end
