class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :notebook
end
