module Yuetai
  class Authors < Grape::API
    resource :authors do
      desc 'Get all authors'
      get do
        authors = Author.order("updated_at DESC").all
        authors
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          author = Author.find(params[:id])
          author
        end
      end

      post do
        user = authenticate_user_from_token!
        if user
          # create author
          author = Author.new(params[:author])
          author.user_id = user.id
          if author.save
            {status: 201}
          else
            {errors: 'author create failed'}
          end
        else
          {errors: 'Access denied', status: 403}
        end
      end
    end
  end
end
