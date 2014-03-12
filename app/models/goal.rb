class Goal < ActiveRecord::Base
	belongs_to :user
	belongs_to :goal_category
	belongs_to :goal_type

	after_create :create_usergoal

	private
		def create_usergoal
			ug = UserGoal.create(user_id: self.user_id, goal_id: self.id, state: "0")
		end
end
