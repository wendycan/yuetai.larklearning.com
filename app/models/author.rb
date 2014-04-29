class Author < ActiveRecord::Base

  has_many :articles

  scope :recent, ->(num) { order('created_at DESC').limit(num) }

end
