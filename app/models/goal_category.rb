class GoalCategory < ActiveRecord::Base
  validates :name, presence: true

  def self.get_goal_categories(_params)
    if _params[:id].present?
      GoalCategory.find_by_id(_params[:id])
    elsif _params[:goal_id].present?
      goal = Goal.find_by_id(_params[:goal_id])
      goal.goal_category
    else
      GoalCategory.all
    end
  end
end
