module Yuetai
  class Series < Grape::API
    resource :series do
      desc 'Get all series'
      get do
        authenticate!
        series = current_user.articles.where(template: 'series').order("created_at DESC").all
        series
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          authenticate!
          series = current_user.articles.find(params[:id])
          JSON.parse series.to_json(:include => :user)
        end

        put do
          authenticate!
          update_article
        end

        desc 'Delete a series'
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
