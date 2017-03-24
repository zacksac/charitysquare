class CreateSquareBets < ActiveRecord::Migration
  def change
    create_table :square_bets do |t|
      t.integer :charityusersquare_id
      t.integer :user_1
      t.integer :user_2
      t.integer :user1_amt
      t.integer :user2_amt
      t.string :winner

      t.timestamps
    end
  end
end
