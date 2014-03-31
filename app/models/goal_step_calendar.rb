class GoalStepCalendar < ActiveRecord::Base
  validates :goal_id, :user_id, :description, :date, presence: true
  belongs_to :goal 
  belongs_to :user

  def self.get_goal_step_calendars(_params)
    if _params[:goal_id].present?
      goal_step_calendars = GoalStepCalendar.where(goal_id: _params[:goal_id])
    elsif _params[:user_id].present?
      goal_step_calendars = GoalStepCalendar.where(user_id: _params[:user_id])
    elsif _params[:goal_step_calendar_id].present?
      goal_step_calendars = GoalStepCalendar.find_by_id(_params[:goal_step_calendar_id])
    else
      goal_step_calendars = GoalStepCalendar.all
    end
  end
end
