class Goal < ActiveRecord::Base
	belongs_to :user
	belongs_to :goal_category
	belongs_to :goal_type
end
