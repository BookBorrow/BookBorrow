class Borrow < ActiveRecord::Base
  belongs_to :user_book
  belongs_to :user

  def overdue?
  	Date.today > end_date
  end
end
