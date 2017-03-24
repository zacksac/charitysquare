class AddActiveToBet < ActiveRecord::Migration
  def change
    add_column :bets, :active, :boolean
  end
end
