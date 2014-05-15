class BooksController < ApplicationController
  def index
    @books = Book.order("updated_at DESC").all
  end
  def show
    @book = Book.find_by_id(params[:id])
  end
end
