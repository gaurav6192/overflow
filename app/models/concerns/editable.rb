module Editable
  extend ActiveSupport::Concern

  included do
    def self.editable
      has_many :edits, as: :editable, dependent: :destroy
    end
  end
end
