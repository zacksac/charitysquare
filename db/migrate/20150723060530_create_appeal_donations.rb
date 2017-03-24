class CreateAppealDonations < ActiveRecord::Migration
  def change
    create_table :appeal_donations do |t|
      t.integer :appeal_id
      t.integer :user_id
      t.integer :amount

      t.timestamps
    end
  end
end
