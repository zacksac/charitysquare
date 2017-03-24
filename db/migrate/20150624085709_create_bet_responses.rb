class CreateBetResponses < ActiveRecord::Migration
  def change
    create_table :bet_responses do |t|
      t.integer :bet_id
      t.integer :user_id
      t.boolean :response

      t.timestamps
    end
  end
end
