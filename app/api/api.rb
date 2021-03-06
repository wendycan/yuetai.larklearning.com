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
      error!('405 Method Not Allowed', 405) unless current_user.level > 0
    end

    def authenticateSuper!
      error!('401 Unauthorized', 401) unless current_user
      error!('405 Method Not Allowed', 405) unless current_user.level > 1
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
      @current_user.words_count += HTML::FullSanitizer.new.sanitize(article.body).length
      if article.save
        @current_user.save
        {status: 201}
      else
        {errors: 'article create failed', status: 422}
      end
    end

    def update_article
      article = current_user.articles.find(params[:id])

      old_count = HTML::FullSanitizer.new.sanitize(article.body).length
      article.title = params[:title]
      article.body = params[:body]
      article.tag_list = params[:tag_list]
      article.language = params[:language]
      article.template = params[:template]
      delta = HTML::FullSanitizer.new.sanitize(article.body).length - old_count
      @current_user.words_count += delta
      if article.save
        @current_user.save
        {status: 200}
      else
        {errors: 'article update failed', status: 422}
      end
    end

    def delete_article
      article = current_user.articles.find(params[:id])
      count = HTML::FullSanitizer.new.sanitize(article.body).length
      article.destroy!
      @current_user.words_count -= count
      @current_user.save
      {status: 204}
    end
  end

  mount Yuetai::Articles
  mount Yuetai::Tags
  mount Yuetai::Blogs
  mount Yuetai::Series
  mount Yuetai::Presentations
  mount Yuetai::Users
  mount Yuetai::Notebooks

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
