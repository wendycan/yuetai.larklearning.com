Dir["#{Rails.root}/app/api/yuetai/*.rb"].each { |file| require file }

class Api < Grape::API
  #api
  version 'v1', using: :path
  format :json
  default_format :json
  desc 'Return version info'
  get do
    {version: '1'}
  end

  helpers do
    def current_user
      @current_user ||= locate_user
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
      error!('400 Not found', 400) unless current_user.editable
    end

    def locate_user
      token = params['auth_token'] || headers['Auth-Token']
      User.find_by(authentication_token: token) if token.present?
    end

    def create_article
      # create article
      article = Article.new()
      article.title = params[:title]
      article.body = params[:body]
      article.tag_id = params[:tag_id]
      article.template = params[:template]
      article.user_id = @current_user.id
      if article.save
        {status: 201}
      else
        {errors: 'article create failed', status: 422}
      end
    end

    def update_article
      article = Article.find(params[:id])
      article.title = params[:title]
      article.body = params[:body]
      article.tag_id = params[:tag_id]
      article.template = params[:template]
      if article.save
        {status: 200}
      else
        {errors: 'article update failed', status: 422}
      end
    end

    def delete_article
      article = Article.find(params[:id])
      article.destroy!
      {status: 204}
    end
  end
  mount Yuetai::Blogs
  mount Yuetai::Series
  mount Yuetai::Presentations

end
