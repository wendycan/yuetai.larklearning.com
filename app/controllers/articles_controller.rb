class ArticlesController < ApplicationController
  def index
    @blogs = Article.order("updated_at DESC").where(template: 'blog')
  end

  def show
    @blog = Article.find_by_id(params[:id])
  end
end
