class AddFollowStatusToCharityusersquares < ActiveRecord::Migration
  def change
    add_column :charityusersquares, :follow_status, :string, :default => "follow"
  end
end
