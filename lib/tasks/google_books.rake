namespace :gb do

  task :gb_env do
    ENV["RAILS_ENV"] ||= 'development'
		require File.expand_path("../../../config/environment", __FILE__)
		Bundler.require(:default)
  end

  desc "Seed the database using books retrieved from Google Books API"
  task :seed_books => [:gb_env] do
    require_relative "../../db/seed_titles.rb"
    require_relative "google_books.rb"

    @titles_array.each do |title|

      begin
        GoogleBooksSeeder.get_books(title)
      rescue LoadError
        puts "Couldn't load books by title #{title}"
        next
      end

      puts "Persisted book records for title #{title}"

    end

  end

end
