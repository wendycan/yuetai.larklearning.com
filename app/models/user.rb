class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  before_create :generate_authentication_token

  has_many :articles
  has_many :comments
  has_many :notebooks

  def update_user_words_count
    count = 0
    self.articles.where(template: 'blog').each do |article|
      count += HTML::FullSanitizer.new.sanitize(article.body).length
    end
    self.words_count = count
  end

  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.hex 20
      break unless self.class.exists?(authentication_token: authentication_token)
    end
  end
end
