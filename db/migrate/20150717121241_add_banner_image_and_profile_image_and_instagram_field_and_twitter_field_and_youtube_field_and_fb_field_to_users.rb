class AddBannerImageAndProfileImageAndInstagramFieldAndTwitterFieldAndYoutubeFieldAndFbFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banner_image, :string
    add_column :users, :profile_image, :string
    add_column :users, :instagram_field, :string
    add_column :users, :twitter_field, :string
    add_column :users, :youtube_field, :string
    add_column :users, :fb_field, :string
  end
end
