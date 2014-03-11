class User < ActiveRecord::Base
	has_many :user_goals
	def goals
		UserGoal.where(user_id: self.id)
	end
end
