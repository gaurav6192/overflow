class Session < ApplicationRecord
  validates_presence_of :auth_token, :user
  validates_uniqueness_of :auth_token

  belongs_to :user

  ignore_deleted
end
