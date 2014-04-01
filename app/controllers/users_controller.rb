class UsersController < ApplicationController
    # before_action :login_required, :only => [:edit, :update, :index, :show]
  def show
    @user = User.find(params[:id])
    @library = @user.library
  end
end
