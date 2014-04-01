class User < ActiveRecord::Base
  has_many :user_books
  has_many :borrows, :through => :user_books
  has_many :books, :through => :user_books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def library
    self.user_books
  end

  def loans
    self.user_books.borrows
  end
end
