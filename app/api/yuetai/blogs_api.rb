module Yuetai
  class Blogs < Grape::API
    resource :blogs do
      desc 'Get all blogs'
      get do
        authenticate!
        blogs = Article.order("created_at DESC").all
        blogs
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          authenticate!
          blog = Article.find(params[:id])
          blog
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


      post do
        authenticate!
        create_article
      end
    end
  end
end