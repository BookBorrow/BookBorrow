class AddReturnedToBorrows < ActiveRecord::Migration
  def change
    add_column :borrows, :returned, :boolean
  end
end
