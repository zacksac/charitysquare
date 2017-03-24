class CreateSquareTickets < ActiveRecord::Migration
  def change
    create_table :square_tickets do |t|
      t.integer :charityusersquare_id
      t.integer :user_id
      t.integer :amount

      t.timestamps
    end
  end
end
