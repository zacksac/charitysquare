class AddDaysleftToCharityusersquare < ActiveRecord::Migration
  def change
    add_column :charityusersquares, :daysleft, :integer
    add_column :charityusersquares, :price, :integer
  end
end
