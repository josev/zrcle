class GoalRemindsController < ApplicationController
  before_action :set_goal_remind, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id].present?
      @goal_reminds = GoalRemind.where(user_id: params[:user_id])
    elsif params[:goal_id].present?
      @goal_reminds = GoalRemind.where(goal_id: params[:goal_id])
    elsif params[:goal_remind_id].present?
      @goal_reminds = GoalRemind.find_by_id(params[:goal_remind_id])
    else
      @goal_reminds = GoalRemind.all
    end
    render json: @goal_reminds
  end

  def show
    render json: @goal_remind
  end

  def new
    @goal_remind = GoalRemind.new
    render json: @goal_remind
  end

  def edit
    render json: @goal_remind
  end

  def create
    @goal_remind=GoalRemind.new(goal_remind_params)
    if @goal_remind.save
      render json: @goal_remind
    else
      render json: {errors: @goal_remind.errors}
    end
  end

  def update
    if @goal_remind.update(goal_remind_params)
      render json: @goal_remind
    else
      render json: {errors: @goal_remind.errors}
    end
  end

  def destroy
    if @goal_remind.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @goal_remind.errors}
    end
  end

  private
    def set_goal_remind
      @goal_remind = GoalRemind.find_by_id(params[:id])
    end

    def goal_remind_params
      params.require(:goal_remind).permit(:user_id, :goal_id, :frequently, :time)
    end
end
