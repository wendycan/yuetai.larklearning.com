module Yuetai
  class Tags < Grape::API
    resource :tags do
      desc 'Get all tags'

      get do
        authenticate!
        tags = Tag.all
        present tags, with: Entities::Tag
      end

      delete do
        authenticateSuper!
        tag = Article.find(params[:id])
        tag.destroy!
        {status: 204}
      end
    end
  end
end
