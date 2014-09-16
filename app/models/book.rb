class Book < ActiveRecord::Base
  has_many :excerpts

  validates :name, presence: true
end
