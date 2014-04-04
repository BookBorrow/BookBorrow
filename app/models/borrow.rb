class Borrow < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  belongs_to :user_book
  before_save :set_borrow_date
  validates_presence_of :borrower_name, :borrower_email, :duration_in_days, :borrow_date

  def set_borrow_date
    self.borrow_date ||= Date.today
  end

  def due_date
    self.borrow_date + self.duration_in_days
  end

  def due_date_in_words
    words = time_ago_in_words(self.due_date)
    self.due_date.past? ? "+#{words}" : "-#{words}"
  end

  def checkout_date_in_words
    "#{time_ago_in_words(self.checkout_date)} ago"
  end

  def due_date= due_date
    unless due_date.empty?
      self.duration_in_days = DateTime.parse(due_date) - Date.today 
    end
  end

  def overdue?
    self.due_date < Date.today && !self.returned
  end

  def user
    self.user_book.user
  end

  def self.active
    where(:returned => false)
  end

  def book
    self.user_book.book
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
