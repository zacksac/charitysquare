class CreateAppeals < ActiveRecord::Migration
  def change
    create_table :appeals do |t|
      t.integer :charityusersquare_id
      t.string :enddate
      t.string :startdate
      t.text :description
      t.integer :user_id
      t.string :charitytype
      t.boolean :active
      t.string :appeal_type
      t.string :specific_appeal_description

      t.timestamps
    end
  end
end
