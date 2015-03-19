class SiteController < ApplicationController
  def index
    @tags = Tag.order("updated_at DESC").all
    # @authors = Author.order("updated_at DESC").all
    @articles = Article.order("updated_at DESC").all
  end

  def search
  end
end
