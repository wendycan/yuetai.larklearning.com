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

    def article_params
      params[:blog].permit(:title, :body, :user_id, :tag_id, :template)
    end

  end
  mount Yuetai::Blogs
  mount Yuetai::Series
  mount Yuetai::Presentations

end
