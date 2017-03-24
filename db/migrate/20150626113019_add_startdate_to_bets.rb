class AddStartdateToBets < ActiveRecord::Migration


  def change
    add_column :bets, :startdate, :string
  end


end
