class Article < ActiveRecord::Base

  belongs_to :node
  belongs_to :author

end
