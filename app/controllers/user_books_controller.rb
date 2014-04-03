class UserBooksController < ApplicationController
  before_action :require_signin
  before_action :authenticate_on_create, :only => "create"
  before_action :authenticate_on_destroy, :only => "destroy"

  # DELETE users/:user_id/user_books/:id
  def destroy
    @user_book = UserBook.find(params[:id])
    @user = @user_book.user

    if @user_book.destroy
      redirect_to (user_path(@user))
    else
      render 'user/show'
    end
  end


  # POST /users/:user_id/user_books
  def create
    @user = User.find(params[:user_id])
    user_book = @user.user_books.build(user_book_params)
    if user_book.save
      redirect_to @user
    else
      render 'users/show'
    end
  end

  private
  def user_book_params
    params.require(:user_book).permit(:from_isbn)
  end

  def authenticate_on_create
    unless User.find(params[:user_id]) == current_user
      sign_out current_user
      redirect_to new_user_session_path, :alert => "Goodbye!"
    end
  end

  def authenticate_on_destroy
    unless UserBook.find(params[:id]).user == current_user
      sign_out current_user
      redirect_to new_user_session_path, :alert => "Goodbye!"
    end
  end
end
