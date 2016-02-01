class Article < ActiveRecord::Base
  # attr_accessible :body, :title, :tag_list, :template, :language

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :body, presence: true
  validates :template, presence: true, inclusion: { in: ['blog', 'series', 'presentation'] }
  validates :language, inclusion: { in: ['html', 'markdown', 'simditor']}

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

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first
      # Tag.where(name: n.strip).first_or_create!
    end
  end

end
