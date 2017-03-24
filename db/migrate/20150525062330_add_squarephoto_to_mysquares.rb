class AddSquarephotoToMysquares < ActiveRecord::Migration
  def change
    add_column :mysquares, :squarephoto, :string
  end
end
