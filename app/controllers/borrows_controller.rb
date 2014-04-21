class BorrowsController < ApplicationController
  before_action :set_borrow,      :only => [:show, :destroy, :remind, :update]
  before_action :set_user,        :only => [:destroy]

  def index
    @user = User.find(params[:id])
    @borrows = @user.active_borrows
    @inactive_borrows = @user.inactive_borrows
  end
  
  def create
    if current_user.nil?
      session[:forwarding] = params
      if params["from_isbn"] == ""
        #search page to get from_isbn
        #then redirect_to new_user_registration_path
      else
        redirect_to new_user_registration_path
      end
    else
      @user_book = UserBook.find(params[:user_book_id])
      @borrow = @user_book.borrows.build(borrow_params)
      @borrow.returned = false
      if @borrow.save
        redirect_to user_borrows_path(@user_book.user), 
          :notice => "Lent #{@user_book.book.title} to #{@borrow.borrower_email}"
      else
        flash.now[:alert] = "Please complete the form."
        render 'borrows/new'
      end
    end
  end

  def new
    @user_book = UserBook.find(params[:user_book_id])
    ensure_borrowable @user_book
    @borrow = Borrow.new
  end

  def show
  end

  def update
    @borrow.update(borrow_params)
  end

  # GET /user_books/:user_book_id/borrows/:id/remind
  def remind
    BorrowMailer.reminder_email(@borrow).deliver
    redirect_to [@borrow.user, @borrow], :notice => "A reminder was sent!"
  end

  def destroy
    if @borrow.destroy
      flash.now.notice = "Borrow destroyed"
      @borrows = User.find(params[:user_id]).borrows
      render 'index'
    end
  end

  private

  def borrow_params
    params.require(:borrow).permit(:borrower_name, :borrower_email, :borrow_date, :duration_in_days, :returned, :due_date, :from_isbn)
  end

  def set_borrow
    @borrow = Borrow.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
  
  def ensure_borrowable user_book
    unless user_book.borrowable? 
      redirect_to user_borrow_path(user_book.user, user_book.current_borrow), :notice => "Item is currently on loan."
    end
  end

end
