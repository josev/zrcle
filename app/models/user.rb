class User < ActiveRecord::Base
	validates_uniqueness_of :email, :uid
	has_many :user_goals
	has_one :user_configurations
	has_one :profile
	def self.goals
		UserGoal.where(user_id: self.id)
	end
end
