class AddFormtypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :formtype, :string
  end
end
