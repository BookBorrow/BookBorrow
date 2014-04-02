class Borrow < ActiveRecord::Base
  belongs_to :user_book
  belongs_to :user


  def due_date
    self.borrow_date + self.duration_in_days
  end

  def overdue?
    self.due_date < Date.today
  end

  
end
