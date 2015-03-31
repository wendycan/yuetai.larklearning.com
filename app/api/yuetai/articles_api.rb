module Yuetai
  class Articles < Grape::API
    resource :articles do
      desc 'Get all articles'

      route_param :id, requirements: /[^\/]+/ do
        get do
          article = Article.find(params[:id])
          article
        end

      end
    end
  end
end
