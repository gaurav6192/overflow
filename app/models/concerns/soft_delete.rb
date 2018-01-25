module SoftDelete
  extend ActiveSupport::Concern
  
  included do
    alias_method :really_destroy, :destroy
    alias_method :really_destroy!, :destroy!

    def self.ignore_deleted
      default_scope { where(deleted_at: nil) }
    end

    def destroy
      self.deleted_at = Time.now
      self.save
    end

    def destroy!
      self.deleted_at = Time.now
      self.save!
    end
  end
end