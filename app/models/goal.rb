class Goal < ActiveRecord::Base
	validates :name, :description, :goal_category_id, :expected_result, :date, :goal_type_id, presence: true
	has_many :user
	has_one :goal_category
	has_one :goal_type


	#after_create :create_usergoal

	#private
	#	def create_usergoal
	#		ug = UserGoal.create(user_id: self.user_id, goal_id: self.id, state: "0")
	#	end
end
