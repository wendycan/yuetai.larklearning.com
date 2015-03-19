class Tag < ActiveRecord::Base
  has_many :articles
end
