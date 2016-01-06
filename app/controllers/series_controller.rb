class SeriesController < ApplicationController
  def index
    @series = Article.order("created_at DESC").where(template: 'series')
  end

  def show
    @series = Article.find_by_id(params[:id])
  end
end
