class AddAppealIdToCharityMedia < ActiveRecord::Migration
  def change
    add_column :charity_media, :appeal_id, :integer
  end
end
