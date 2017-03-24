class CreateSquareRaisers < ActiveRecord::Migration
  def change
    create_table :square_raisers do |t|
      t.string :name
      t.integer :square_id
      t.string :brand_page

      t.timestamps
    end
  end
end
