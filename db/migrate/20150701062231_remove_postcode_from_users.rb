class RemovePostcodeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :postcode, :integer
  end
end
