class ArticlesController < ApplicationController

  def show
    @article = Article.find_by_id(params[:id])
  end

end
