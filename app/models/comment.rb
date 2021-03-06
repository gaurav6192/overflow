class Comment < ApplicationRecord
  ignore_deleted
  editable
  revisionable
	
	validates_presence_of :content, :user

  belongs_to :user
  belongs_to :commentable, polymorphic: true, optional: true
  has_one :comment_stat, dependent: :destroy
end
