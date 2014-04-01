class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :isbn
      t.string :author
      t.string :cover_url

      t.timestamps
    end
  end
end
