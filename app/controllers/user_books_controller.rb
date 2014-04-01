class UserBooksController < ApplicationController
  def destroy
    @user_book = UserBook.find(params[:id])
    @user = @user_book.user
    @user_book.destroy
    redirect_to (user_path(@user))
  end

  def create
    @user = User.find(params[:user_id])
    user_book = @user.user_books.build(user_book_params)
    if user_book.save
      @library = @user.library.page(params[:page]).per(10)
      redirect_to @user
    else
      render 'users/show'
    end
  end

  private
  def user_book_params
    params.require(:user_book).permit(:from_isbn)
  end
end
