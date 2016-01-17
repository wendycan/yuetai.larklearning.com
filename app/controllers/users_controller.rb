class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    @articles = @user.articles
  end

end
