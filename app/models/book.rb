class Book < ActiveRecord::Base
  has_many :excerpts
end
