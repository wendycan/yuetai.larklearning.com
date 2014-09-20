class Book < ActiveRecord::Base
  has_many :excerpts

  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates_length_of :desc, :maximum => 200
end
