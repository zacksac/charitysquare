class CreateCharitychildren < ActiveRecord::Migration
  def change
    create_table :charitychildren do |t|
      t.string :name
      t.string :email
      t.string :address
      t.boolean :active
      t.integer :user_id

      t.timestamps
    end
  end
end
