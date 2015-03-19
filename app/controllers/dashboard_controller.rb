class DashboardController < ApplicationController
  def index
    @blogs = Article.order("updated_at DESC").where(template: 'blog')
  end

  def show
  end
end
