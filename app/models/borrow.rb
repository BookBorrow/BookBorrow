class Borrow < ActiveRecord::Base
  belongs_to :user_book
  belongs_to :user
end
