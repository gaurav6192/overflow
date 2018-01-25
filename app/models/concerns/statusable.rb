module Statusable
  extend ActiveSupport::Concern

  included do
    def self.statusable
      belongs_to :status
    end
  end
end
