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

  describe "validation" do
    it "validates uniqueness of isbn" do
      @book = create(:book)
      @book2 = build(:book, :isbn => @book.isbn)
      expect(@book2).not_to be_valid
    end

    it "validates numericality for isbn with non-numbers" do
      @book = Book.new(:isbn => "1ABC234ABC")
      expect(@book).not_to be_valid
    end

    it "validates length <= 9 for isbn" do
      @book = Book.new(:isbn => "1234")
      expect(@book).not_to be_valid
    end

    it "validates length <= 9 for isbn" do
      @book = Book.new(:isbn => "123456789")
      expect(@book).to be_valid
    end


    it "creates a new book from Google using isbn" do
      Book.create_from_google("0241950430")
      expect(Book.last.title).to eq("The Catcher in the Rye")
    end

    it "creates a new book from Google using title" do
      Book.create_from_google("Everyone Poops", mode = "title")
      expect(Book.last.title).to eq("Everyone Poops")
    end

    it "returns results for a search of an existing book" do
      @book = create(:book)
      # binding.pry
      expect(Book.text_search("Catcher").to_a.count).should be >=1
    end

    it "returns all results for a search with no query" do
      #returns active record so it should not be an array...
      @book = create(:book)
      expect(Book.text_search("").count).to eq(1)
      # expect(Book.text_search("")).to be_a(Array)
    end

  end
end
