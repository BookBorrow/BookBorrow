require 'spec_helper'

describe User do
  describe "associations" do
    it "should have many books" do
      @user = create(:user)
      @book = create(:book)
      @user.books << @book
      expect(@user.books.count).to eq(1)
    end

    it "should have many borrows" do
      @user = create(:user)
      @user.borrows << Borrow.create
      expect(@user.borrows.count).to eq(1)
    end

    it "should have many loans" do
    end
  end
end
