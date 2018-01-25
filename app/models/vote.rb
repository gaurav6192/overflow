class Vote < ApplicationRecord
  validates_presence_of :user, :vote_type

  belongs_to :user
  belongs_to :vote_type
  belongs_to :voteable, polymorphic: true, optional: true

  ignore_deleted
end
