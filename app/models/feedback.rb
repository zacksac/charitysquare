class Feedback < ActiveRecord::Base
	letsrate_rateable "accuracy", "satisfaction", "quick_dispatch", "reasonable"
end
