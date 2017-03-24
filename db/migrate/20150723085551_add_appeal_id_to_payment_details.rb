class AddAppealIdToPaymentDetails < ActiveRecord::Migration
  def change
    add_column :payment_details, :appeal_id, :integer
  end
end
