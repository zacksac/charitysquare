class AddProfileTypeAndEmailTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_type, :string
    add_column :users, :email_type, :string
  end
end
