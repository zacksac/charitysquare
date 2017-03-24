class AddUseridAndBetidToPaymentDetails < ActiveRecord::Migration
  def change
    add_column :payment_details, :user_id, :integer
    add_column :payment_details, :bet_id, :integer
  end
end
