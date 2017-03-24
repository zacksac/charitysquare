class AddSubjectToBets < ActiveRecord::Migration
  def change
    add_column :bets, :subject, :string
    add_column :bets, :objective, :string
  end
end
