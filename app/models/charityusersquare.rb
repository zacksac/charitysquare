class Charityusersquare < ActiveRecord::Base
	belongs_to :user
	has_many :squarebets, :dependent => :destroy
	has_many :squarebids, :dependent => :destroy
	has_many :squarebuynows, :dependent => :destroy
	has_many :squaretickets, :dependent => :destroy
	has_many :charitymedium, :class_name => 'CharityMedia'
    # acts_as_followable
end



