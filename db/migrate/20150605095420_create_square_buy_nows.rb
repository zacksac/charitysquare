class CreateSquareBuyNows < ActiveRecord::Migration
  def change
    create_table :square_buy_nows do |t|
      t.integer :charityusersquare_id
      t.integer :user_id
      t.integer :buy_amt

      t.timestamps
    end
  end
end
