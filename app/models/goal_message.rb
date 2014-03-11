class GoalMessage < ActiveRecord::Base
	belongs_to :user, :foreing_key => "from_user_id"
	alias_attribute :from_user, :user
	belongs_to :goal, :foreing_key => "to_user_id"
	alias_attribute :to_goal, :goal
end
