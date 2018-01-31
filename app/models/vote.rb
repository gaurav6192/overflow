class Vote < ApplicationRecord
  ignore_deleted
  
  validates_presence_of :user_stat, :vote_type

  belongs_to :user_stat
  belongs_to :vote_type
  belongs_to :voteable, polymorphic: true, optional: true
end
