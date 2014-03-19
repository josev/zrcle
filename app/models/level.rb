class Level < ActiveRecord::Base
	validates :level_number, :required_points
end
