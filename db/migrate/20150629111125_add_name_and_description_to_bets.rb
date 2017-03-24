class AddNameAndDescriptionToBets < ActiveRecord::Migration
  def change
    add_column :bets, :name, :string
    add_column :bets, :description, :string
  end
end
