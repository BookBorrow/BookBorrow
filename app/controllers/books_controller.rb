class BooksController < ApplicationController

  def index
    @books = Book.all
    # raise 'error'
  end

  def show
  end

end
