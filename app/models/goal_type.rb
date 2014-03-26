class GoalType < ActiveRecord::Base
	validates :name, presence: true
end
