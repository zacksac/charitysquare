class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :feed
      t.string :rating, :default => "Positive"
      t.boolean :arrival, :default => true

      t.timestamps
    end
  end
end
