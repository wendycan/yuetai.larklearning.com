module Yuetai
  class Blogs < Grape::API
    resource :blogs do
      desc 'Get all blogs'
      get do
        blogs = Article.order("created_at DESC").all
        blogs
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          blog = Article.find(params[:id])
          blog
        end
      end

      post do
        user = authenticate_user_from_token!
        if user
          # create article
          blog = Article.new(params[:blog])
          blog.user_id = user.id
          if blog.save
            {status: 201}
          else
            {errors: 'blog create failed'}
          end
        else
          {errors: 'Access denied', status: 403}
        end
      end
    end
  end
end
