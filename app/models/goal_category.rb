class GoalCategory < ActiveRecord::Base
  validates :name, presence: true

  def self.get_goal_categories(_params)
    if _params[:id].present?
      goal_categories = GoalCategory.find_by_id(_params[:id])
    elsif _params[:goal_id].present?
      goal = Goal.find_by_id(_params[:goal_id])
      goal_categories = goal.goal_category
    else
      goal_categories = GoalCategory.all
    end
  end
end
