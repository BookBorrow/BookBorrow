class BorrowsController < ApplicationController
  def create
    @user_book = UserBook.find(params[:id])
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
  private
  def borrow_params
    params.require(:borrow).permit(:borrower_email)
  end
end
