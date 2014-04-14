class GoalStep < ActiveRecord::Base
  validates :goal_id, :description, :title, :order, presence: true
  belongs_to :goal

  def self.get_goal_steps(_params)
    if _params[:goal_id].present?
      goal_steps = GoalStep.where(goal_id: _params[:goal_id])
    elsif _params[:user_id].present?
      goal_steps = GoalStep.where(user_id: _params[:user_id])
    elsif _params[:goal_step_id].present?
      goal_steps = GoalStep.find_by_id(_params[:goal_step_id])
    else
      goal_steps = GoalStep.all
    end
  end
end
