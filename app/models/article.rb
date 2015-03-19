class Article < ActiveRecord::Base

  belongs_to :tag
  # belongs_to :author

  validates :title, presence: true
  validates :body, presence: true
  validates :tag_id, presence: true
  validates :template, presence: true, inclusion: { in: ['blog', 'series', 'presentation'] }

  # before_save :set_node
  scope :recent, ->(num) { order('created_at DESC').limit(num) }
  # def set_node
  #   tag = Node.find_by_name(self.utag)
  #   if tag.nil?
  #     tag = Node.find_by_id(self.node_id)
  #   end
  #   author = Author.find_by_name(self.uauthor)
  #   if author.nil?
  #     author = Author.find_by_id(self.author_id)
  #   end
  #   self.node = tag
  #   self.author = author
  # end
end
