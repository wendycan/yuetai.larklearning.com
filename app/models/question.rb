class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  belongs_to :chap
end
