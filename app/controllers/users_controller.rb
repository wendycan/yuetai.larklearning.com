class UsersController < ApplicationController
  layout 'article', :only => [:show]

  def show
    @user = User.find_by_id(params[:id])
    @articles = @user.articles.order("created_at DESC").where(template: 'blog').paginate(:page => params[:page], :per_page => 10)
  end

end
