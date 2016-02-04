class ArticlesController < ApplicationController
  def index
    @articles = Article.order("created_at DESC").where(template: 'blog').paginate(:page => params[:page], :per_page => 10)
    @authors = User.all
  end

  def show
    @blog = Article.find_by_id(params[:id])
    @user = @blog.user
    @blog.visited_count += 1
    @blog.save
  end
end
