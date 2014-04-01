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
      @user.user_books.first.borrows.create(:user_id => @user2.id)
      expect(@user.user_books.first.borrows.count).to eq(1)
    end
  end
end
