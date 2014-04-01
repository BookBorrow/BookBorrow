class UsersController < ApplicationController
    # before_action :login_required, :only => [:edit, :update, :index, :show]
  def show
    @user = User.find(params[:id])
    @library = @user.library
  end
  
    #For a user, remove the book from their library
  def remove_book
    @user = User.find(params[:id])
  end
end
