class BooksController < ApplicationController

  def index
    @books = Book.all.page(params[:page]).per(10)
    # raise 'error'
  end

  def show
  end

end
