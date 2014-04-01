class User < ActiveRecord::Base
  has_many :user_books
  has_many :borrows
  has_many :books, :through => :user_books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def library
    joins(:books).merge(Book.joins(:user_book).where("user_id = '#{self.id}'"))
  end
end
