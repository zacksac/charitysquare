class AddRoleidToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :roleid, :integer
  end
end
