class GoalRemind < ActiveRecord::Base
	validates :user_id, :goal_id, :frequently, presence: true
	belongs_to :goal
	belongs_to :user
end
