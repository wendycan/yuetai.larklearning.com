module Yuetai
  class Articles < Grape::API
    resource :articles do
      desc 'Get all articles'
      get do
        articles = Article.all
        articles
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          article = Article.find(params[:id])
          article
        end
      end

      post do
        user = authenticate_user_from_token!
        if user
          # create article
          article = Article.new(params[:article])
          article.user_id = user.id
          if article.save
            {status: 201}
          else
            {errors: 'article create failed'}
          end
        else
          {errors: 'Access denied', status: 403}
        end
      end
    end
  end
end
