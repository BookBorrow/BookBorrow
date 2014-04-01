class BooksController < ApplicationController

  def index
    @library = Book.all
  end

  def show
  end
  
end
