class AddPrimaryAddress1AndPrimaryAddress2AndPrimaryAddress3AndPrimaryAddress4AndPrimaryAddressPinAndSecondaryAddress1AndSecondaryAddress2AndSecondaryAddress3AndSecondaryAddress4AndSecondaryAddressPinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_address1, :string
    add_column :users, :primary_address2, :string
    add_column :users, :primary_address3, :string
    add_column :users, :primary_address4, :string
    add_column :users, :primary_address_pin, :string
    add_column :users, :secondary_address1, :string
    add_column :users, :secondary_address2, :string
    add_column :users, :secondary_address3, :string
    add_column :users, :secondary_address4, :string
    add_column :users, :secondary_address_pin, :string
  end
end
