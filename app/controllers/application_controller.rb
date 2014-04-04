class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if session[:forwarding].present?
      @user_book = current_user.user_books.create(session[:forwarding]["user_book"])
      if session[:forwarding]["controller"] = "borrows"
        @borrow = @user_book.borrows.create(:borrower_email => session[:forwarding]["user_book"]["borrower_name"],
                                            :borrower_name  => session[:forwarding]["user_book"]["borrower_email"],
                                            :due_date       => session[:forwarding]["user_book"]["due_date"],
                                            :returned       => false)
        flash[:notice] = "Added to your library and put on loan"
      else
        flash[:notice] = "Added to your library"
      end
      session[:forwarding] = nil
      user_path(@user)
    else
      super
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)        { |u| u.permit(:email, :password, :password_confirmation, :name, :public, :user_user_book) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :name, :public) }
  end

  private
  def require_signin
    unless user_signed_in?
      redirect_to new_user_session_path, :alert => "Please sign in."
    end
  end

  def require_signin
    unless user_signed_in?
      redirect_to new_user_session_path, :alert => "Please sign in."
    end
  end

end
