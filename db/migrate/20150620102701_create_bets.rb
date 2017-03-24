class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :charityusersquare_id
      t.integer :amount
      t.text :question
      t.datetime :timeend
      t.boolean :response
    end
  end
end
