module Yuetai
  class Tags < Grape::API
    resource :tags do
      desc 'Get all tags'

      get do
        authenticate!
        tags = Tag.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
        present tags, with: Entities::Tag
      end

      post do
        authenticateSuper!
        tag = Tag.new()
        tag.name = params[:name]
        if tag.save
          present tag, with: Entities::Tag
        else
          {errors: 'tag created failed', status: 422}
        end
      end

      put do
        authenticateSuper!
        tag = Tag.find(params[:id])
        tag.name = params[:name]
        if tag.save
          {status: 200}
        else
          {errors: 'tag update failed', status: 422}
        end
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
