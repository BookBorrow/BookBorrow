class UserBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :borrows

  def on_loan?
  	borrows.last.returned?
  end

  def from_isbn= isbn
    if book = Book.find_by(:isbn => isbn)
      self.book_id = book.id
    else
      book = Book.create_from_google(isbn)
      self.book_id = book.id
    end
  end

  def borrower
    if (self.borrows.empty?)
      return nil
    else
      User.find(self.borrows.last.user_id).email
    end
  end
end
