class ArticlesController < ApplicationController
  def index
  end

  def show
    @article = Article.find_by_id(params[:id])
  end
end
