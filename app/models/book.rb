class Book < ActiveRecord::Base
  has_many :user_books
end
