class AddNameToBorrows < ActiveRecord::Migration
  def change
    add_column :borrows, :borrower_name, :string
  end
end
