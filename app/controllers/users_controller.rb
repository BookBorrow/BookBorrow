class UsersController < ApplicationController
  #before_action :require_login, :only => "show"
  #before_action :authorize_user, :only => "show"
  
  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
    @library = @user.library.page(params[:page]).per(10)
    @user_book = UserBook.new
  end
  
    #For a user, remove the book from their library
  def remove_book
    @user = User.find(params[:id])
  end

  private 
  def authorize_user
    unless user_signed_in? && params[:id].to_i == current_user.id
      redirect_to root_path, :alert => "Improper access rights."
    end
  end
end
