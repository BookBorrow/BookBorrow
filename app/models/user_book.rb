class UserBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :borrows

  def borrowed?
    self.borrows.last && !self.borrows.last.returned?
  end


  def author
    book.author
  end

  def title
    book.title
  end

  def description
    book.description
  end

  def cover_url
    book.cover_url
  end

  def latest_borrow
    self.borrows.last
  end

  def borrowable?
    !self.borrowed?
  end

  def on_loan?
    self.borrowed?
  end

  def current_borrow
    self.borrows.last
  end

  def from_isbn= isbn
    if book = Book.find_by(:isbn => isbn)
      self.book_id = book.id
    else
      book = Book.create_from_google(isbn)

        self.book_id = book.id unless book.nil?
    end
  end
end
