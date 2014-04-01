class UserBooksController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @user.user_books.build(user_book_params)
  end

  private
  def user_book_params
    params.require(:user_book).permit(:from_isbn)
  end
end
