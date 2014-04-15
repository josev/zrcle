class UserGoal < ActiveRecord::Base
  validates :user_id, :goal_id, :state, presence: true
  belongs_to :user
  belongs_to :goal

  def self.get_user_goals(_params)
    if _params[:user_goal_id].present?
      UserGoal.find_by_id(_params[:user_goal_id])
    elsif _params[:user_id].present?
      UserGoal.where(user_id: _params[:user_id])
    elsif _params[:goal_id].present?
      UserGoal.where(goal_id: _params[:goal_id])
    else
      UserGoal.all
    end
  end
end
