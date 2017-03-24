class AddCharitytypeToCharityusersquares < ActiveRecord::Migration
  def change
    add_column :charityusersquares, :charitytype, :string
  end
end
