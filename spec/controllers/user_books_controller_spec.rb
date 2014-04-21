require 'spec_helper'

describe UserBooksController do
  describe "Renders Templates" do
    before(:each) do
      @book = create(:book)
      @user = create(:user)
      @user2 = create(:user)
      #create entry in user_books
      @user.books << @book
      @user_book = @user.user_books.first
    end

    it "renders the show template" do
      get :show, id: @user_book.id, user_id: @user.id
      expect(response).to render_template("show")
    end
  end
end
