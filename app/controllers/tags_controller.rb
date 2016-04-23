class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_id(params[:id])
    @tags = Tag.all
    @articles = @tag.articles.order("created_at DESC")
      .where(template: 'blog').paginate(:page => params[:page], :per_page => 10)
  end
end
