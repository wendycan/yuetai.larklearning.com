class SiteController < ApplicationController
  def index
    @tags = Node.all
    @authors = Author.all
    @articles = Article.all
  end
end
