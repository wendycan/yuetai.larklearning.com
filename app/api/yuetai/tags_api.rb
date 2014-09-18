module Yuetai
  class Tags < Grape::API
    resource :tags do
      desc 'Get all tags'
      get do
        tags = Node.order("updated_at DESC").all
        tags
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          tag = Node.find(params[:id])
          tag
        end
      end

      post do
        user = authenticate_user_from_token!
        if user
          # createtag
          tag = Node.new(params[:tag])
          tag.user_id = user.id
          if tag.save
            {status: 201}
          else
            {errors: 'tag create failed'}
          end
        else
          {errors: 'Access denied', status: 403}
        end
      end
    end
  end
end
