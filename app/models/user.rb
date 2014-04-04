class User < ActiveRecord::Base
  has_many :user_books
  has_many :borrows, :through => :user_books
  has_many :books, :through => :user_books
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  before_save :set_public

  def id_is? id
    self.id == id
  end

  def borrows
    Borrow.joins(:user_book).where(:user_books => { :user_id => self.id })
  end

  def active_borrows
    Borrow.active.joins(:user_book).where(:user_books => { :user_id => self.id })
  end

  def display_name
    return name if name
    email
  end

  def library_size
    user_books.count
  end

  def number_of_loans
    on_loan_collection.count
  end

  def available_library
    user_books.select do |book|
      book.persisted? && book.borrowable? 
    end
  end

  def library
    user_books.select do |book|
      book.persisted?
    end
  end

  def on_loan_collection
    user_books.select(&:on_loan?)
  end

  protected

  def set_public
    self.public = true if self.public.nil?
  end

end
