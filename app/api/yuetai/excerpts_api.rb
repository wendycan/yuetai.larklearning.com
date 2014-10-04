module Yuetai
  class Excerpts < Grape::API
    resource :excerpts do
      desc 'Get all excerpts'
      get do
        excerpts = Excerpt.order("created_at DESC").all
        excerpts
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          excerpt = Excerpt.find(params[:id])
          excerpt
        end
      end

    end
  end
end
