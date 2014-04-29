class Article < ActiveRecord::Base

  belongs_to :node
  belongs_to :author

  validates :utag, presence: true

  before_save :set_node

  def set_node
    tag = Node.find_by_name(self.utag)
    author = Author.find_by_name(self.uauthor)
    self.node = tag
    self.author = author
  end
end
