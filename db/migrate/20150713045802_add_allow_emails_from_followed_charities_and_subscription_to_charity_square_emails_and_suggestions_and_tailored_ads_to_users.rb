class AddAllowEmailsFromFollowedCharitiesAndSubscriptionToCharitySquareEmailsAndSuggestionsAndTailoredAdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allow_emails_from_followed_charities, :boolean
    add_column :users, :subscription_to_charity_square_emails, :boolean
    add_column :users, :suggestions, :boolean
    add_column :users, :tailored_ads, :boolean
  end
end
