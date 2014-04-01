class CreateUserBooks < ActiveRecord::Migration
  def change
    create_table :user_books do |t|
      t.user_id :integer
      t.book_id :integer

      t.timestamps
    end
  end
end
