class WelcomeController < ApplicationController

  def index
    @programming_books = Book.text_search("ruby")
    @nyt_bestsellers = Book.text_search("new york times")
    # @korean_books = Book.text_search("마음을")
    
    @books = Book.text_search(params[:query]).page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json  {render json: Book.text_search(params[:query])}
    end
  end

  def query
    @books = Book.text_search(params[:query])
    render :partial =>"bookquery"
  end

end