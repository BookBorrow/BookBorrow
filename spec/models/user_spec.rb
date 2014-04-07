require 'spec_helper'



describe User do

  describe "associations" do
    it "should have many books" do
      @user = create(:user)
      @book = create(:book)
      @user.books << @book
      expect(@user.books.count).to eq(1)
    end
  end

  describe "books" do
    it "should keep track of library size" do
      @user = create(:user)
      @book = create(:book)
      @user.books << @book
      @user.books << Book.create(title: "The Winds of Winter",description: "Amazing", isbn: "100000000", author: "GRRM")
      expect(@user.library_size).to eq(2)
      expect(@user.library.count).to eq(2)
    end

    it "should keep track of the available books in the library" do
      @user = create(:user)
      @book = create(:book)
      @user.books << @book
      @user.books << Book.create(title: "The Winds of Winter",description: "Amazing", isbn: "100001230", author: "GRRM")
      expect(@user.available_library.count).to eq(2)
      @user_book = @user.user_books[0]
      @borrow = @user_book.borrows.build(borrower_name: "Sam", borrower_email: "sam@example.com", duration_in_days: 2, borrow_date: Time.now)
      @borrow.returned = false
      @borrow.save
      expect(@user.available_library.count).to eq(1)
    end
  end


end
