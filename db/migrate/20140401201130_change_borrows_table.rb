class ChangeBorrowsTable < ActiveRecord::Migration
  def up
  	add_column :borrows, :borrower_email, :string
  	remove_column :borrows, :user_id
  end
  def down
  	remove_column :borrows, :borrower_email
  	add_column :borrows, :user_id, :integer
  end
end
