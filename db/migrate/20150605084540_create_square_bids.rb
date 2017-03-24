class CreateSquareBids < ActiveRecord::Migration
  def change
    create_table :square_bids do |t|
      t.integer :charityusersquare_id
      t.integer :user_id
      t.integer :bid_amt
      t.string :winner

      t.timestamps
    end
  end
end
