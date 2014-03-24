class UserGoal < ActiveRecord::Base
	validates :user_id, :goal_id, :status, presence: true
	belongs_to :user
	belongs_to :goal
end
