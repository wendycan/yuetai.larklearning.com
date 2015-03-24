module Yuetai
  class Presentations < Grape::API
    resource :presentations do
      desc 'Get all presentations'
      get do
        authenticate!
        presentations = current_user.articles.where(template: 'presentation').order("created_at DESC").all
        presentations
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          authenticate!
          presentation = current_user.articles.find(params[:id])
          presentation
        end

        put do
          authenticate!
          update_article
        end

        desc 'Delete a presentation'
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
