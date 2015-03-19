class TagsController < ApplicationController

  def show
    @tag = Tag.find_by_id(params[:id])
  end

end
