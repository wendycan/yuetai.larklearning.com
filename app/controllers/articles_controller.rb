class ArticlesController < ApplicationController
  def index
    @blogs = Article.order("created_at DESC").where(template: 'blog').paginate(:page => params[:page], :per_page => 10)

  end

  def show
    @blog = Article.find_by_id(params[:id])
    @blog.visited_count += 1
    @blog.save
  end
end
