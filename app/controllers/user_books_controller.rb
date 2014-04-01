class UserBooksController < ApplicationController
  def destroy
    @user_book = UserBook.find(params[:id])
    @user = @user_book.user
    @user_book.destroy
    redirect_to (user_path(@user))
  end
end
