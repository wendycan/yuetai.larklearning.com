class Author < ActiveRecord::Base

  include Gravtastic
  gravtastic

  has_many :articles

  scope :recent, ->(num) { order('created_at DESC').limit(num) }

end
