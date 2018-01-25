class Post < ApplicationRecord
	validates_presence_of :title, :body, :user

  belongs_to :user
  statusable
  
  has_one :post_stat, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :tags

  ignore_deleted
  commentable
  editable
end
