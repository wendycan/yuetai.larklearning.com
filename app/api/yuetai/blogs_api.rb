require 'net/ftp'

module Yuetai
  class Blogs < Grape::API
    resource :blogs do
      desc 'Get all blogs'
      get do
        authenticate!
        blogs = current_user.articles.where(template: 'blog').order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
        present blogs, with: Entities::Blog
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          authenticate!
          blog = current_user.articles.find(params[:id])
          present blog, with: Entities::Blog
        end

        put do
          authenticate!
          update_article
        end

        desc 'Delete a blog'
        delete do
          authenticate!
          delete_article
        end
      end

      post :upload do
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

      post do
        authenticate!
        create_article
      end
    end
  end
end
