class UserBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :borrows

  #POST user/:user_id/user_books
  # params { :user_id => 1,  :user_book => { :from_isbn => 1234 } }

  def from_isbn= isbn
    if book = Book.find_by_isbn(isbn)
      self.book_id = book.id
    else
      book = Book.create_from_google(isbn)
      self.book_id = book.id
    end
  end
end
