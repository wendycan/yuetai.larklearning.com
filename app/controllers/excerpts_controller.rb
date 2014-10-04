class ExcerptsController < ApplicationController
  def create
  end

  def index
  end

  def show
    @excerpt = Excerpt.find_by_id(params[:id])
    @book = @excerpt.book
  end
end
