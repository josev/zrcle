class GoalType < ActiveRecord::Base
  validates :name, presence: true

  def self.get_goal_types(_params)
    if _params[:goal_id].present?
      goal = Goal.find_by_id(_params["goal_id"])
      goal_types = @goal.goal_type
    else
      goal_types = GoalType.all
    end
  end
end
