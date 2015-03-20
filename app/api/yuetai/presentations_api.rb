module Yuetai
  class Presentations < Grape::API
    resource :presentations do
      desc 'Get all presentations'
      get do
        presentations = Article.where(template: 'presentations').order("created_at DESC").all
        presentations
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          presentation = Article.find(params[:id])
          presentation
        end
      end

      post do
        authenticate!
        if !@current_user.nil?
          # create author
          presentation = Article.new(params[:presentation])
          presentation.user_id = @current_user.id
          if presentation.save
            {status: 201}
          else
            {errors: 'presentation create failed'}
          end
        else
          {errors: 'Access denied', status: 403}
        end
      end
    end
  end
end
