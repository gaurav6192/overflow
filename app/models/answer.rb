class Answer < ApplicationRecord
  ignore_deleted
  commentable
	editable
	revisionable
  
  validates_presence_of :body, :post, :user

  belongs_to :post
  belongs_to :user
  has_one :answer_stat, dependent: :destroy
end