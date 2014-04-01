class UserBooksController < ApplicationController
  def destroy
    @user_book = UserBook.find(params[:id])
    @user = @user_book.user
    @user_book.destroy
    redirect_to (user_path(@user))
  end

  def create
    @user = User.find(params[:user_id])
    @user.user_books.build(user_book_params)
  end

  private
  def user_book_params
    params.require(:user_book).permit(:from_isbn)
  end
end
