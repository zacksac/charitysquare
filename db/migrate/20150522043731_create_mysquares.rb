class CreateMysquares < ActiveRecord::Migration
  def change
    create_table :mysquares do |t|
      t.string :name
      t.integer :square_raiser_id
      t.string :info
      t.string :lat
      t.string :long

      t.timestamps
    end
  end
end
