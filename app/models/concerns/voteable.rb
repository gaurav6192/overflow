module Voteable
  extend ActiveSupport::Concern

  included do
    def self.voteable
      has_many :votes, -> { where(deleted_at: nil) }, as: :voteable, dependent: :destroy
    end
  end
end
