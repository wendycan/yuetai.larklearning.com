class Chap < ActiveRecord::Base
  belongs_to :book
  has_many :comments
  has_many :questions
end
