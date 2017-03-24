class CreatePaymentDetails < ActiveRecord::Migration
  def change
    create_table :payment_details do |t|
      t.string :transaction_id
      t.string :sender_email
      t.string :receiver_email
      t.date :date
      t.string :charitytype
      t.float :amount

      t.timestamps
    end
  end
end
