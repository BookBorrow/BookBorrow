class UsersController < ApplicationController
  before_action :set_user, :only => ["show"]
  before_action :confirm_public, :only => "show"
  
  def index
    @users = User.all
  end


  def show
    @active_borrows = @user.active_borrows.limit(4)
    @placeholders =  4 - @active_borrows.length
    @user_books = @user.user_books.page(params[:page]).per(10)
    @user_book = @user.user_books.build
    @borrow = Borrow.new
  end
  
    #For a user, remove the book from their library
  def remove_book
    @user = User.find(params[:id])
  end

  private 
  def confirm_public
    @user = User.find(params[:id])
    if !@user.public && (@user != current_user)
      redirect_to root_path, :alert => "Sorry, this user's profile is private."
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
