module Yuetai
  class Users < Grape::API
    resource :users do
      desc 'Get all users'

      get do
        authenticateSuper!
        users = User.paginate(:page => params[:page], :per_page => 10)
        present :users, users, with: Entities::User
        present :per_page, users.per_page
        present :page, users.current_page
        present :total_pages, users.total_pages
        present :total_entries, users.total_entries
      end

      route_param :id, requirements: /[^\/]+/ do
        put do
          authenticate!
          user = current_user
          user.email = params[:email]
          user.desc = params[:desc]
          user.github = params[:github]
          user.webchat = params[:webchat]
          user.avator = params[:avator]
          user.username = params[:username]
          if user.save
            {status: 200}
          else
            {errors: 'user update failed', status: 422}
          end
        end
      end
    end
  end
end
