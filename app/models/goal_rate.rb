class GoalRate < ActiveRecord::Base
  validates :user_id, :goal_id, presence: true
  belongs_to :user
  belongs_to :goal

  def self.get_goal_rates(_params)
    if _params[:goal_id].present?
      GoalRate.where(goal_id: _params[:goal_id])
    elsif _params[:user_id]
      GoalRate.where(user_id: _params[:user_id])
    elsif _params[:goal_rate_id].present?
      GoalRate.find_by_id(_params[:goal_rate_id])
    else
      GoalRate.all
    end
  end
end
