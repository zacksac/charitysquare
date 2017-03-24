class AddNameToCharityusersquare < ActiveRecord::Migration
  def change
    add_column :charityusersquares, :name, :string
    add_column :charityusersquares, :material, :string
  end
end
