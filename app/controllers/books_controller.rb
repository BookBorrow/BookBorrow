class BooksController < ApplicationController
  before_action :set_book, only: [:show, :destroy]

  def index
    @books = Book.text_search(params[:query]).page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json  {render json: Book.text_search(params[:query])}
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :isbn, :author, :cover_url, :categories, :ratings_count, :average_rating, :page_count)
  end
end