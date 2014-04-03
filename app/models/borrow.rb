class Borrow < ActiveRecord::Base
  belongs_to :user_book

  def due_date
    self.borrow_date + self.duration_in_days
  end

  def due_date= due_date
    self.duration_in_days = due_date - Date.today 
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

end
