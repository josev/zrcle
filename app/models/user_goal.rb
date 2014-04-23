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

  def start_goal
    g = Goal.find_by_id(self.goal_id)
    u = User.find_by_id(self.user_id)
    g.steps.each do |step|
      user_step = UserStep.new
      user_step.user_id = self.user_id
      user_step.status = step.order == 1 ? 2 : 1
      user_step.goal_step_id = step.id
      user_step.save
    end
  end

end
