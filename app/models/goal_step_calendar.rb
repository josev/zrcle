class GoalStepCalendar < ActiveRecord::Base
	validates :goal_id, :user_id, :description, :date, presence: true
	belongs_to :goal 
	belongs_to :user
end
