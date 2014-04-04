class BooksController < ApplicationController
  before_action :set_book, only: [:show, :destroy]

  def index
    @books = Book.text_search(params[:query]).page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json  {render json: Book.text_search(params[:query])}
    end
  end

  def new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to "/books?#{{:query => @book.title}.to_query}"
    else
      flash[:notice] = @book.errors.full_messages.join(" ")
      render "new"
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
    params.require(:book).permit(:title_from_google, :title, :description, :isbn, :author, :cover_url, :categories, :ratings_count, :average_rating, :page_count)
  end
end