class AddFollowStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :follow_status, :string, :default => "follow"
  end
end
