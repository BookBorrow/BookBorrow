require 'spec_helper'

describe Borrow do
  describe "validations" do
    it "should have many borrows" do
      @book = create(:book)
      @user = create(:user)
      @book.user_books.create(:user => @user)
      @user_book = @book.user_books.first

    end
  end
end
