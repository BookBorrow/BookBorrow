class Book < ActiveRecord::Base
  has_many :user_books
  has_many :users, :through => :user_books
  before_validation :normalize_isbn, :on => :create
  validates_uniqueness_of :isbn

  include PgSearch
  pg_search_scope :search, against: [:title, :description, :isbn, :author, :cover_url], using: {tsearch: {dictionary: "english"}}

  def self.create_from_google(query, mode="isbn")
    if mode == "isbn"
  	  search = GoogleBooks.search("isbn:#{Book.strip_isbn(query)}", {:count => 1, :api_key => "AIzaSyCvOuvO_hQS_ZULj8Q4vIBttWefh6kv8zY"})
    elsif mode =="title"
      search = GoogleBooks.search("title: #{query}", {:count => 1, :api_key => "AIzaSyCvOuvO_hQS_ZULj8Q4vIBttWefh6kv8zY"})
    end
  	if search.first
  		record = search.first
  		book = Book.create(:title => record.title, 
                         :description => record.description, 
                         :author=> record.authors_array[0]||record.authors||"unknown", 
                         :isbn => record.isbn_13, 
                         :cover_url => record.image_link,
                         :categories => record.categories,
                         :ratings_count => record.ratings_count,
                         :average_rating => record.average_rating,
                         :page_count => record.page_count)
  	end
  end

# NOT NECESSARY
  # def title_from_google=(title)
  #   search = GoogleBooks.search("title: #{title}", {:count => 1, :api_key => "AIzaSyCvOuvO_hQS_ZULj8Q4vIBttWefh6kv8zY"})
  #   if search.first
  #     record = search.first
  #     self.title = record.title
  #     self.description = record.description
  #     self.author = record.authors_array[0]||record.authors||"unknown"
  #     self.isbn = record.isbn
  #     self.cover_url = record.image_link
  #     self.categories = record.categories
  #     self.ratings_count = record.ratings_count,
  #     self.average_rating = record.average_rating,
  #     self.page_count = record.page_count
  #   end
  # end

  def self.text_search(query)
    if query.present?
      search(query)
    else
      order("created_at DESC")
    end
  end

private
  def normalize_isbn
    self.isbn = Book.strip_isbn(self.isbn) unless self.isbn.nil?
  end

  def self.strip_isbn(isbn)
    isbn.to_s.gsub(/\D/,"").to_f
  end
end
