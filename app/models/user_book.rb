class UserBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :borrows

  def on_loan?
  	self.borrows.last && !self.borrows.last.returned?
  end

  def latest_borrow
    self.borrows.last
  end

  def from_isbn= isbn
    if book = Book.find_by(:isbn => isbn)
      self.book_id = book.id
    else
      book = Book.create_from_google(isbn)
      self.book_id = book.id
    end
  end
end
