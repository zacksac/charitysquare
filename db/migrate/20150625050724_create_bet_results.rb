class CreateBetResults < ActiveRecord::Migration
  def change
    create_table :bet_results do |t|
      t.boolean :answer
      t.integer :bet_id

      t.timestamps
    end
  end
end
