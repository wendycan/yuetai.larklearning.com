class SiteController < ApplicationController
  def index
    @tags = Node.order("created_at DESC").all
    @authors = Author.order("created_at DESC").all
    @articles = Article.order("created_at DESC").all
  end
end
