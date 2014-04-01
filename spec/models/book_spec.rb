require 'spec_helper'

describe Book do
  describe "associations" do
    it "should have many users" do 
      @user = create(:user)
      @book = create(:book)
      @book.users << @user
      expect(@book.users.count).to eq(1)
    end
  end

  describe "valdiation" do
    it "validates uniqueness of isbn" do
      @book = create(:book)
      @book2 = build(:book, :isbn => @book.isbn)
      expect(@book2).not_to be_valid
    end

    it "validates numbericality and length >= 9 for isbn" do
    end
  end
end
