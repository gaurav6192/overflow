module Editable
  extend ActiveSupport::Concern

  included do
    def self.editable
      has_many :edits, -> { where(deleted_at: nil) }, as: :editable, dependent: :destroy
    end
  end
end
