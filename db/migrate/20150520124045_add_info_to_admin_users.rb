class AddInfoToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :info, :string
  end
end
