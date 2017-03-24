class AddUserIdToCharityusersquares < ActiveRecord::Migration
  def change
    add_column :charityusersquares, :user_id, :integer
  end
end
