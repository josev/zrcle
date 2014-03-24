class GoalStepCalendarsController < ApplicationController
  before_action :set_goal_step_calendar, only: [:update, :destroy]

  def index
    @goal_step_calendars = GoalStepCalendar.all
    render json: @goal_step_calendars
  end

  def show
  end

  def new
    @goal_step_calendar = GoalStepCalendar.new
    render json: @goal_step_calendar
  end

  def edit
  end

  def create
    @goal_step_calendar=GoalStepCalendar.new(goal_step_calendar_params)
    if @goal_step_calendar.save
      render @goal_step_calendar
    else
      render json: @goal_step_calendar.errors
    end
  end

  def update
    if @goal_step_calendar.update(goal_step_calendar_params)
      render json: @goal_step_calendar
    else
      render json: @goal_step_calendar.errors
    end
  end

  def destroy
    if @goal_step_calendar.destroy
      render text: "Deleted"
    else
      render json: @goal_step_calendar.errors
    end
  end

  private
    def set_goal_step_calendar
      @goal_step_calendar = GoalStepCalendar.find(params[:id])
    end

    def goal_step_calendar_params
      params.require(:goal_step_calendar).permit(:goal_id, :user_id, :description, :status, :date)
    end
end
