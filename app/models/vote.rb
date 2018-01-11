class Vote < ApplicationRecord
  belongs_to :vote_type
  belongs_to :voteable
end
