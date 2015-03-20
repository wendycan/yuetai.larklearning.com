module Yuetai
  class Series < Grape::API
    resource :series do
      desc 'Get all series'
      get do
        series = Article.where(template: 'series').order("created_at DESC").all
        series
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          series = Article.find(params[:id])
          series
        end
      end

      post do
        user = authenticate_user_from_token!
        if user
          # create author
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
