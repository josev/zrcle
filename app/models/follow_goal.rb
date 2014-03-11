class FollowGoal < ActiveRecord::Base
	belongs_to :user
	belongs_to :goal, :foreing_key => "follow_goal_id"
	alias_attribute :follow_goal, :goal
end
