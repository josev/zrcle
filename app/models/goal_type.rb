class GoalType < ActiveRecord::Base
	validates :name, presence: true
	belongs_to :goal
end
