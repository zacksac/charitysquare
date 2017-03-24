class AddDisplayNameAndUkTaxpayerAndNiNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :UK_taxpayer, :boolean
    add_column :users, :ni_number, :string
  end
end
