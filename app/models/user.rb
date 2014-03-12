class User < ActiveRecord::Base
	validates_uniqueness_of :email, :uid
	has_many :user_goals
	def goals
		UserGoal.where(user_id: self.id)
	end
end
