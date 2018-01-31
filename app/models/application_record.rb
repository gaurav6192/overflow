class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Commentable
  include Editable
  include Revisionable
  include SoftDelete
  include Voteable
end
