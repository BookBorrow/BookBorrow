require 'spec_helper'

describe UserBook do
  describe "associations" do
    it "should have many borrows" do
      @book = create(:book)
      @user = create(:user)
      @user2 = create(:user)
      @user.books << @books
      @user.user_books.borrows.create(:user => @user2)
      expect(@user.user_books.borrows.count).to eq(1)
    end
  end
end
