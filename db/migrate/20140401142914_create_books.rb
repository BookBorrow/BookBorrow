class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text   :description
      t.string :isbn
      t.string :author
      t.string :cover_url
      t.string :categories
      t.integer :ratings_count
      t.integer :average_rating
      t.integer :page_count

      t.timestamps
    end
  end
end
