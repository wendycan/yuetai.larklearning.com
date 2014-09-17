module Yuetai
  class Books < Grape::API
    resource :books do
      desc 'Get all books'
      get do
        books = Book.order("updated_at DESC").all
        books
      end

      route_param :id, requirements: /[^\/]+/ do
        get do
          book = Book.find(params[:id])
          book
        end
      end

      post do
        user = authenticate_user_from_token!
        if user
          # createbook
          book = Book.new(params[:book])
          if book.save
            {status: 201}
          else
            {errors: 'book create failed'}
          end
        else
          {errors: 'Access denied', status: 403}
        end
      end
    end
  end
end
