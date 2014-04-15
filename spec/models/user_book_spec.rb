require 'spec_helper'

describe UserBook do
  describe "associations" do
    it "should have many borrows" do
      @book = create(:book)
      @user = create(:user)
      @user2 = create(:user)
      #create entry in user_books
      @user.books << @book

      #create borrow on user_book
      @user.user_books.first.borrows.create({
                                              :borrower_email => @user2.email,
                                              :borrower_name => @user2.name,
                                              :duration_in_days => 3,
                                              :borrow_date => Date.today
      })
      expect(@user.user_books.first.borrows.count).to eq(1)
    end
  end

  describe "validations" do
  end
end
