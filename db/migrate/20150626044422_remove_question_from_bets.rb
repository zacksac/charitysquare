class RemoveQuestionFromBets < ActiveRecord::Migration
  def change
    remove_column :bets, :question, :string
  end
end
