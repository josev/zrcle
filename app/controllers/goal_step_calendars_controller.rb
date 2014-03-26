class GoalStepCalendarsController < ApplicationController
  before_action :set_goal_step_calendar, only: [:show, :edit, :update, :destroy]

  def index
    if params[:goal_id].present?
      @goal_step_calendars = GoalStepCalendar.where(goal_id: params[:goal_id])
    elsif params[:user_id].present?
      @goal_step_calendars = GoalStepCalendar.where(user_id: params[:user_id])
    elsif params[:goal_step_calendar_id].present?
      @goal_step_calendars = GoalStepCalendar.find_by_id(params[:goal_step_calendar_id])
    else
      @goal_step_calendars = GoalStepCalendar.all
    end
    render json: @goal_step_calendars
  end

  def show
    render json: @goal_step_calendar
  end

  def new
    @goal_step_calendar = GoalStepCalendar.new
    render json: @goal_step_calendar
  end

  def edit
    render json: @goal_step_calendar
  end

  def create
    @goal_step_calendar=GoalStepCalendar.new(goal_step_calendar_params)
    if @goal_step_calendar.save
      render json: @goal_step_calendar
    else
      render json: {errors: @goal_step_calendar.errors}
    end
  end

  def update
    if @goal_step_calendar.update(goal_step_calendar_params)
      render json: @goal_step_calendar
    else
      render json: {errors: @goal_step_calendar.errors}
    end
  end

  def destroy
    if @goal_step_calendar.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @goal_step_calendar.errors}
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
