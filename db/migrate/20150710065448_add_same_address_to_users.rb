class AddSameAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :same_address, :boolean
  end
end
