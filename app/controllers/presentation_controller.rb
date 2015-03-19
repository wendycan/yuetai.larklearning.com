class PresentationController < ApplicationController
  def index
    @presentations = Article.order("updated_at DESC").where(template: 'presentation')
  end

  def show
    @presentation = Article.find_by_id(params[:id])
  end
end
