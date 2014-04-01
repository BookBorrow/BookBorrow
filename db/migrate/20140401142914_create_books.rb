class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :isbn
      t.strring :author
      t.string :cover_url

      t.timestamps
    end
  end
end
