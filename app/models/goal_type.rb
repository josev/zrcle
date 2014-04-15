class GoalType < ActiveRecord::Base
  validates :name, presence: true

  def self.get_goal_types(_params)
    if _params[:goal_id].present?
      goal = Goal.find_by_id(_params["goal_id"])
      @goal.goal_type
    else
      GoalType.all
    end
  end
end
