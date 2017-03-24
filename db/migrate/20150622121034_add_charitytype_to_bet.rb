class AddCharitytypeToBet < ActiveRecord::Migration
  def change
    add_column :bets, :charitytype, :string
  end
end
