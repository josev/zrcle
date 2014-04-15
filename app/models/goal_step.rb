class GoalStep < ActiveRecord::Base
  validates :goal_id, :description, :title, :order, presence: true
  belongs_to :goal

  def self.get_goal_steps(_params)
    if _params[:goal_id].present?
      GoalStep.where(goal_id: _params[:goal_id]).order(:order)
    elsif _params[:user_id].present?
      GoalStep.where(user_id: _params[:user_id]).order(:goal_id,:order)
    elsif _params[:goal_step_id].present?
      GoalStep.find_by_id(_params[:goal_step_id])
    else
      GoalStep.all.order(:goal_id,:order)
    end
  end
end
