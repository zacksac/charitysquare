class AddUserEmailToInvitedUsers < ActiveRecord::Migration
  def change
    add_column :invited_users, :user_email, :string
  end
end
