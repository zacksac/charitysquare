class AddFollowStatusToBets < ActiveRecord::Migration
  def change
    add_column :bets, :follow_status, :string, :default => "follow"
  end
end
