require 'spec_helper'

describe BooksController do
  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "renders the show template for a book" do
    pending
    @book = create(:book)
    get :create, id: @book.id
    expect(response).to render_template("show")
  end
  
end
