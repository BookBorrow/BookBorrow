class BorrowsController < ApplicationController
  
  def create
    @user_book = UserBook.find(params[:user_book_id])
    @borrow = @user_book.borrows.build(borrow_params)
    @borrow.returned = false
    if @borrow.save
      redirect_to @user_book.user,
        :notice => "Lent #{@user_book.book.title} to #{@borrow.borrower_email}"
    else
      redirect_to @user_book.user,
        :notice => "Could not save."
    end
  end

  def new
    @user_book = UserBook.find(params[:user_book_id])
    @borrow = Borrow.new

  end

  def show
    @user_book = UserBook.find(params[:user_book_id])
    @borrow = Borrow.find(params[:id])
    @books = Book.all
  end

  private

  def borrow_params
    params.require(:borrow).permit(:borrower_email, :borrow_date, :duration_in_days)
  end

end
