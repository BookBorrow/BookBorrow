class AddBorrowerNameToBorrows < ActiveRecord::Migration
  def change
    add_column :borrows, :string, :borrower_name
  end
end
