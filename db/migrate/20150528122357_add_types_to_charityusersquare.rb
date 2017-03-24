class AddTypesToCharityusersquare < ActiveRecord::Migration
  def change
    add_column :charityusersquares, :types, :string
  end
end
