module Revisionable
  extend ActiveSupport::Concern

  included do
    def self.revisionable
      has_many :revisions, -> { where(deleted_at: nil) }, as: :revisionable, dependent: :destroy
    end
  end
end
