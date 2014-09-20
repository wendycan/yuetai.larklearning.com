class Book < ActiveRecord::Base
  has_many :excerpts

  mount_uploader :image, ImageUploader

  validates :name, presence: true
end
