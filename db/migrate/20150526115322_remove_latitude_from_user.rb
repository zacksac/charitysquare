class RemoveLatitudeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :latitude, :string
  end
end
