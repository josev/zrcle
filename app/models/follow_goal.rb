class FollowGoal < ActiveRecord::Base
	validates :user_id, :follow_goal_id, presence: true
	belongs_to :user
	belongs_to :goal, :foreign_key => "follow_goal_id"
	alias_attribute :follow_goal, :goal

	def self.get_follow_goals(_params)
    if _params[:follow_goal_id]
      follow_goals = FollowGoal.find_by_id(_params[:follow_goal_id])
    elsif _params[:user_id]
      follow_goals = FollowGoal.where(user_id: _params[:user_id])
    elsif _params[:goal_id]
      follow_goals = FollowGoal.where(follow_goal_id: _params[:goal_id])
    else
      follow_goals = FollowGoal.all
    end
  end
end
