class AddEnddateToBet < ActiveRecord::Migration
  def change
    add_column :bets, :enddate, :string
  end
end
