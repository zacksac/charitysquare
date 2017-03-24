class AddBetIdToInvitedUsers < ActiveRecord::Migration
  def change
    add_column :invited_users, :bet_id, :integer
  end
end
