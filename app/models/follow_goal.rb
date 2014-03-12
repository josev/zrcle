class FollowGoal < ActiveRecord::Base
	validates :user_id, :follow_goal_id, presence: true
	belongs_to :user
	belongs_to :goal, :foreign_key => "follow_goal_id"
	alias_attribute :follow_goal, :goal
end
