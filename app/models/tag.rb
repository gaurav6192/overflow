class Tag < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :posts
  has_and_belongs_to_many :users
end
