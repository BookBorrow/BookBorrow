class WelcomeController < ApplicationController
before_action :confirm_signed_in, :only => "index"

  def index
    @books = Book.text_search(params[:query]).page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json  {render json: Book.text_search(params[:query])}
    end
  end

  def query
    @books = Book.text_search(params[:query])
    render :partial =>"bookquery"
  end

  private 
  def confirm_signed_in
    if !current_user.nil?
      @user = current_user
      redirect_to @user
    end
  end
end