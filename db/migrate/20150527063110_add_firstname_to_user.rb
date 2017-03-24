class AddFirstnameToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :charityname, :string
    add_column :users, :charitytype, :string
    add_column :users, :charitynumber, :integer
    add_column :users, :category, :string
    add_column :users, :country, :string
    add_column :users, :town, :string
    add_column :users, :postcode, :integer
    add_column :users, :webaddress, :string
    add_column :users, :picture, :string
    add_column :users, :mission, :string
    add_column :users, :opt1, :string
    add_column :users, :opt2, :string
  end
end
