module Voteable
  extend ActiveSupport::Concern

  included do
    def self.voteable
      has_many :votes, as: :voteable, dependent: :destroy
    end
  end
end
