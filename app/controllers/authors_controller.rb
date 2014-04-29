class AuthorsController < ApplicationController

  def show
    @author = Author.find_by_id(params[:id])
  end

end
