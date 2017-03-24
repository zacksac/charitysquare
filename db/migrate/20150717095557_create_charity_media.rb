class CreateCharityMedia < ActiveRecord::Migration
  def change
    create_table :charity_media do |t|
      t.integer :charityusersquare_id
      t.integer :bet_id
      t.string :types
      t.string :desc
      t.string :picture

      t.timestamps
    end
  end
end
