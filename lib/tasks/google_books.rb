class GoogleBooksSeeder
def self.get_books(title)
  response = GoogleBooks.search(title)
  return raise LoadError if !response

  response.to_a.each_with_index do |book, i|

    begin
      db_book = Book.create({
        :title => book.title,
        :author => book.authors_array.first,
        :description => book.description,
        :cover_url => book.image_link,
        :isbn => book.isbn_13
      })
    rescue
      puts "Could not create #{title}, (##{i}) : ("
      next
    end

    if !db_book.persisted?
      puts "Could not persist #{title},  (##{i}) : ("
      next
    else
      puts "Created book #{db_book.id}, '#{db_book.title}', #{db_book.isbn} : )"
    end

  end

end

class PersistenceError < StandardError
end
class LoadError < StandardError
end

end
