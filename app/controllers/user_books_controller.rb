class UserBooksController < ApplicationController
  before_action :authenticate_on_destroy, :only => "destroy"
  before_action :set_user_book, :only => ["destroy", "show"]

  # DELETE users/:user_id/user_books/:id
  def destroy
    @user = @user_book.user

    if @user_book.destroy
      redirect_to (user_path(@user))
    else
      render 'user/show'
    end
  end

  def show
  end

  def index
    @user = User.find(params[:user_id])
    @user_books = @user.user_books
  end

  # POST /users/:user_id/user_books
  def create
    if current_user.nil?
      session[:user_book] = params
      redirect_to new_user_registration_path
    else
      @user = User.find(params[:user_id])
      user_book = @user.user_books.build(user_book_params)
      if user_book.id.nil?
        redirect_to @user, :alert => "Not valid ISBN: #{user_book_params[:from_isbn]}"
      else
        if user_book.save
          redirect_to @user
        else
          render 'users/show'
        end
      end
    end
  end

  private
  def user_book_params
    params.require(:user_book).permit(:from_isbn)
  end

  # def authenticate_on_create
  #   unless User.find(params[:user_id]) == current_user
  #     sign_out current_user
  #     redirect_to new_user_session_path, :alert => "Goodbye!"
  #   end
  # end
  def set_user_book
    @user_book = UserBook.find(params[:id])
  end

  def authenticate_on_destroy
    unless UserBook.find(params[:id]).user == current_user
      sign_out current_user
      redirect_to new_user_session_path, :alert => "Goodbye!"
    end
  end
end
