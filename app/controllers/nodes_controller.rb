class NodesController < ApplicationController

  def show
    @node = Node.find_by_id(params[:id])
  end

end
