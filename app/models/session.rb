class Session < ApplicationRecord
  ignore_deleted
  
  validates_presence_of :auth_token, :user
  validates_uniqueness_of :auth_token

  belongs_to :user
end
