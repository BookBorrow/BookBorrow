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

  protected

  def set_public
    self.public = true if self.public.nil?
  end

end
