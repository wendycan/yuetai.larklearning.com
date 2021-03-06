module Yuetai
  class Tags < Grape::API
    resource :tags do
      desc 'Get all tags'

      get do
        authenticate!
        if @params[:all] == 'true'
          tags = Tag.order("created_at DESC")
          present tags, with: Entities::Tag
        else
          tags = Tag.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
          present :tags, tags, with: Entities::Tag
          present :per_page, tags.per_page
          present :page, tags.current_page
          present :total_pages, tags.total_pages
          present :total_entries, tags.total_entries
        end
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
      route_param :id, requirements: /[^\/]+/ do
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
          tag = Tag.find(params[:id])
          tag.destroy!
          {status: 204}
        end
      end
    end
  end
end
