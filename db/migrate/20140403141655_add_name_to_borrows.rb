class AddNameToBorrows < ActiveRecord::Migration
  def change
    add_column :borrows, :name, :string
  end
end
