module Revisionable
  extend ActiveSupport::Concern

  included do
    def self.revisionable
      has_many :revisions, as: :revisionable, dependent: :destroy
    end
  end
end
