module Yuetai
  class Articles < Grape::API
    resource :articles do
      desc 'Get all articles'
      get do
        blogs = Article.where(template: 'blog').order("created_at DESC").all
        blogs
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          article = Article.where(template: params[:template]).find(params[:id])
          JSON.parse article.to_json(:include => :user)
        end

        get :comment_users do
          article = Article.all.find(params[:id])
          comments = article.comments
          users = []
          comments.each do |comment|
            users.push comment.user.username
          end
          users
        end

        resource :comments do
          get do
            blog = Article.all.find(params[:id])
            comments = blog.comments
            comments
          end

          post do
            authenticate!
            article = Article.find(params[:id])
            comment = Comment.new()
            comment.article = article
            comment.user = @current_user
            comment.text = params[:text]
            if article.nil?
              {status: 404}
            elsif comment.save
              {status: 201}
            else
              {errors: 'comment create failed', status: 422}
            end
          end

          route_param :comment_id, requirements: /[^\/]+/ do
            put do
              authenticate!
              comment = current_user.comments.find(params[:comment_id])

              comment.text = params[:text]
              if comment.save
                {status: 200}
              else
                {errors: 'comment update failed', status: 422}
              end
            end

            delete do
              authenticate!
              comment = current_user.comments.find(params[:comment_id])
              comment.destroy!
              {status: 204}
            end
          end
        end
      end
    end
  end
end
