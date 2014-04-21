require 'spec_helper'

describe BooksController do
  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "renders the show template for a book" do
    @book = create(:book)
    get :show, id: @book.id
    expect(response).to render_template("show")
  end

  it "renders the new template for a book" do
    get :new
    expect(response).to render_template("new")
  end

  it "successfully creates a book from valid isbn" do
    post :create, book: {isbn: "0316769487"}
    book = Book.last
    expect(response).to redirect_to("/books?#{{:query => book.title}.to_query}")
  end

  it "does not creates a book from inalid isbn" do
    post :create, book: {isbn: "031"}
    expect(response).to render_template("new")
  end
end
