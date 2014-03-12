class GoalCategory < ActiveRecord::Base
	validates :name, presence: true
end
