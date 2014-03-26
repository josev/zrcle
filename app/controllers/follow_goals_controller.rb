class FollowGoalsController < ApplicationController
  before_action :set_follow_goal, only: [:show, :edit, :update, :destroy]

  def index
    if params[:follow_goal_id]
      @follow_goals = FollowGoal.find_by_id(params[:follow_goal_id])
    elsif params[:user_id]
      @follow_goals = FollowGoal.where(user_id: params[:user_id])
    else
      @follow_goals = FollowGoal.all
    end
    render json: @follow_goals
  end

  def show
    render json: @follow_goal
  end

  def new
    @follow_goal = FollowGoal.new
    render json: @follow_goal
  end

  def edit
    render json: @follow_goal
  end

  def create
    @follow_goal=FollowGoal.new(follow_goal_params)
    if @follow_goal.save
      render json: @follow_goal
    else
      render json: {errors: @follow_goal.errors}
    end
  end

  def update
    if @follow_goal.update(follow_goal_params)
      render json: @follow_goal
    else
      render json: {errors: @follow_goal.errors}
    end
  end

  def destroy
    if @follow_goal.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @follow_goal.errors}
    end
  end

  private
    def set_follow_goal
      @follow_goal = FollowGoal.find_by_id(params[:id])
    end

    def follow_goal_params
      params.require(:follow_goal).permit(:user_id, :follow_goal_id, :status)
    end
end
