class Author < ActiveRecord::Base

  include Gravtastic
  gravtastic

  has_many :articles

  validates :name, presence: true
  validates :email, presence: true

  scope :recent, ->(num) { order('created_at DESC').limit(num) }

end
