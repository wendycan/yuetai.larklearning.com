class NotebooksController < ApplicationController
  layout 'article', :only => [:index, :show]

  def index
    @user = User.find_by_id(params[:user_id])
    @articles = @user.notebooks.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @notebook = @user.notebooks.find_by_id(params[:id])
    @articles = @notebook.notes.paginate(:page => params[:page], :per_page => 10)
  end
end

def format_date(date)
  return date.to_s.split(' UTC')[0]
end
