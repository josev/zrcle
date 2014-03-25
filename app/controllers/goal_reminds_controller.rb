class GoalRemindsController < ApplicationController
  before_action :set_goal_remind, only: [:show, :edit, :update, :destroy]

  def index
    @goal_reminds = GoalRemind.all
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
      render @goal_remind
    else
      render json: @goal_remind.errors
    end
  end

  def update
    if @goal_remind.update(goal_remind_params)
      render json: @goal_remind
    else
      render json: @goal_remind.errors
    end
  end

  def destroy
    if @goal_remind.destroy
      render text: "Deleted"
    else
      render json: @goal_remind.errors
    end
  end

  private
    def set_goal_remind
      @goal_remind = GoalRemind.find(params[:id])
    end

    def goal_remind_params
      params.require(:goal_remind).permit(:user_id, :goal_id, :frequently, :time)
    end
end
