class Article < ActiveRecord::Base

  belongs_to :node
  belongs_to :author

  before_save :set_node

  def set_node
    tag = Node.find_by_name(self.utag)
    if tag.nil?
      tag = Node.find_by_id(self.node_id)
    end
    author = Author.find_by_name(self.uauthor)
    if author.nil?
      author = Author.find_by_id(self.author_id)
    end
    self.node = tag
    self.author = author
  end
end
