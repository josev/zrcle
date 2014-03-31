class GoalRemind < ActiveRecord::Base
  validates :user_id, :goal_id, :frequently, presence: true
  belongs_to :goal
  belongs_to :user

  def self.get_goal_reminds(_params)
    if _params[:user_id].present?
      goal_reminds = GoalRemind.where(user_id: _params[:user_id])
    elsif _params[:goal_id].present?
      goal_reminds = GoalRemind.where(goal_id: _params[:goal_id])
    elsif _params[:goal_remind_id].present?
      goal_reminds = GoalRemind.find_by_id(_params[:goal_remind_id])
    else
      goal_reminds = GoalRemind.all
    end
  end
end
