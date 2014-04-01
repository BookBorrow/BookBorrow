class Book < ActiveRecord::Base
  has_many :user_books
  has_many :users, :through => :user_books
  validates_uniqueness_of :isbn

  include PgSearch
  multisearchable :against => [:description, :isbn, :author, :cover_url]

  def self.create_from_google(isbn)
  	search = GoogleBooks.search("isbn:#{isbn}", {:count => 1, :api_key => "AIzaSyCvOuvO_hQS_ZULj8Q4vIBttWefh6kv8zY"})
  	if search.first
  		record = search.first
  		book = Book.create(:title => record.title, :description => record.description, :author=> record.authors_array[0], :isbn => record.isbn_13, :cover_url => record.image_link)
  	end
  end


end
