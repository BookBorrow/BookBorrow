class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.integer :user_book_id
      t.integer :user_id
      t.date    :borrow_date
      t.integer :duration_in_days

      t.timestamps
    end
  end
end
