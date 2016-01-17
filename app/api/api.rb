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
      error!('400 Not found', 400) unless current_user.level > 0
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
      article.tag_list = params[:tag_list]
      article.template = params[:template]
      article.language = params[:language]
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
      article.tag_list = params[:tag_list]
      article.language = params[:language]
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

  mount Yuetai::Articles
  mount Yuetai::Tags
  mount Yuetai::Blogs
  mount Yuetai::Series
  mount Yuetai::Presentations
  mount Yuetai::Users

  post :upload do
    authenticate!
    file = params[:upload_file][:tempfile]
    path = Settings.ftp_path + Time.now.strftime('%Y%m%d%H%M%S') + '_'+ params[:upload_file][:filename]
    Net::FTP.open(Settings.ftp_server, Settings.ftp_username, Settings.ftp_pass) do |ftp|
      ftp.passive = true
      ftp.putbinaryfile(file, path)
    end
    present({
      :success => true,
      :msg => "success",
      :file_path => Settings.ftp_server_name + path
    })
  end

end
