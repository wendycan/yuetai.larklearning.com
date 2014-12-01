class User < ActiveRecord::Base
  has_many :comments
  has_many :questions
  has_many :answers
  has_many :excerpts
end
