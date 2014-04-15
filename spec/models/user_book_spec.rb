require 'spec_helper'

describe UserBook do
  describe "user book attributes" do
    before(:each) do
      @book = create(:book)
      @user = create(:user)
      @user2 = create(:user)
      #create entry in user_books
      @user.books << @book
      @user_book = @user.user_books.first
    end

    it 'can access it\'s book title' do
      expect(@user_book.title).to eq ("Catcher in the Rye")
    end

    it 'has a description' do
      expect(@user_book.description).to eq ("Horrible")
    end

    it 'has an author' do
      expect(@user_book.author).to eq ("J.D. Salinger")
    end

    it 'has a cover_url' do
      expect(@user_book.cover_url).to eq ("http://readbitchesread.files.wordpress.com/2013/07/catcher-in-the-rye.jpg")
    end

    it 'knows when it is not lent out' do
      expect(@user_book.on_loan?).to eq (false)
    end
  end

  describe "associations" do
    before (:each) do
      @book = create(:book)
      @user = create(:user)
      @user2 = create(:user)
      #create entry in user_books
      @user.books << @book
      @user_book = @user.user_books.first
      #create borrow on user_book
      @user_book.borrows.create({
                                  :borrower_email => @user2.email,
                                  :borrower_name => @user2.name,
                                  :duration_in_days => 3,
                                  :borrow_date => Date.today
      })
    end

    it "should have many borrows" do
      @user_book.borrows.create({
                                  :borrower_email => @user2.email,
                                  :borrower_name => @user2.name,
                                  :duration_in_days => 4,
                                  :borrow_date => Date.today
      })
      expect(@user_book.borrows.count).to eq(2)
    end

    it 'knows when it is lent out' do
      expect(@user_book.on_loan?).to eq (true)
    end

    it 'knows what the last borrow was' do
      borrow = @user_book.borrows.create({
                                           :borrower_email => @user2.email,
                                           :borrower_name => @user2.name,
                                           :duration_in_days => 4,
                                           :borrow_date => Date.today
      })
      expect(@user_book.current_borrow).to eq(borrow)
    end
  end

  describe "validations" do
  end
end
