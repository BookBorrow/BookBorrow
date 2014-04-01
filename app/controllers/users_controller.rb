class UsersController < ApplicationController
    before_action :authenticate_user, :only => [:show]
  
  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
    @library = @user.library
    @user_book = UserBook.new
  end
  
    #For a user, remove the book from their library
  def remove_book
    @user = User.find(params[:id])
  end

  private 
  def authenticate_user
    unless params[:id].to_i == current_user.id
      redirect_to root_path, :notice => "You must be logged in to view this page."
    end
  end
end
