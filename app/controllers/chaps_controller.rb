class ChapsController < ApplicationController
  def index
  end

  def show
    @chap = Chap.find_by_id(params[:id])
  end

end
