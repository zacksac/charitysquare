class Bet < ActiveRecord::Base

  validates_presence_of :charityusersquare_id, :amount, :description, :enddate

  # acts_as_followable
  has_many :bet_results, dependent: :destroy
  has_many :bet_responses, dependent: :destroy
  has_many :payment_details, dependent: :destroy
  has_many :charitymedium, :class_name => 'CharityMedia', dependent: :destroy
end
