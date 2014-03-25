class FollowGoalsController < ApplicationController
  before_action :set_follow_goal, only: [:show, :edit, :update, :destroy]

  def index
    @follow_goals = FollowGoal.all
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
      render @follow_goal
    else
      render json: @follow_goal.errors
    end
  end

  def update
    if @follow_goal.update(follow_goal_params)
      render json: @follow_goal
    else
      render json: @follow_goal.errors
    end
  end

  def destroy
    if @follow_goal.destroy
      render text: "Deleted"
    else
      render json: @follow_goal.errors
    end
  end

  private
    def set_follow_goal
      @follow_goal = FollowGoal.find(params[:id])
    end

    def follow_goal_params
      params.require(:follow_goal).permit(:user_id, :follow_goal_id, :status)
    end
end
