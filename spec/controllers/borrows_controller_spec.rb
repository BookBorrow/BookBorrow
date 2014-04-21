require 'spec_helper'

describe BorrowsController do
  before (:each) do
    @book = create(:book)
    @user = create(:user)
    @user2 = create(:user)
    #create entry in user_books
    @user.books << @book

    #create borrow on user_book
    @borrow = @user.user_books.first.borrows.create({
                                                      :borrower_email => @user2.email,
                                                      :borrower_name => @user2.name,
                                                      :duration_in_days => 3,
                                                      :borrow_date => Date.today
    })
  end

  it "renders the index template" do
    get :index, id: @user.id
    expect(response).to render_template("index")
  end

  it "renders the show template for a borrow" do
    pending "Show currently needs to determine how the borrow is visible"
    get :show, id: @borrow.id
    expect(response).to render_template("show")
  end

  it 'renders the new template for a borrow' do
    user_book = @user.user_books.first 
    user_book.borrows.last.update(returned: true)
    get :new, user_book_id: user_book.id
    expect(response).to render_template("new")
  end

  it 'destroys the borrow' do
    count = @user.user_books.first.borrows.count
    delete :destroy, user_id: @user, id: @borrow
    expect(Borrow.count).to eq(count-1)
  end

end
