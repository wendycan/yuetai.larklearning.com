module Yuetai
  class Tags < Grape::API
    resource :tags do
      desc 'Get all tags'

      get do
        authenticate!
        tags = Tag.all
        tags
      end

    end
  end
end
