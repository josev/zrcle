class UserGoalsController < ApplicationController
  before_action :set_user_goal, only: [:update, :destroy]

  def index
    @user_goals = UserGoal.all
    render json: @user_goals
  end

  def show
  end

  def new
    @user_goal = UserGoal.new
    render json: @user_goal
  end

  def edit
  end

  def create
    @user_goal=UserGoal.new(user_goal_params)
    if @user_goal.save
      render @user_goal
    else
      render json: @user_goal.errors
    end
  end

  def update
    if @user_goal.update(user_goal_params)
      render json: @user_goal
    else
      render json: @user_goal.errors
    end
  end

  def destroy
    if @user_goal.destroy
      render text: "Deleted"
    else
      render json: @user_goal.errors
    end
  end

  private
    def set_user_goal
      @user_goal = UserGoal.find(params[:id])
    end

    def user_goal_params
      params.require(:user_goal).permit(:user_id, :goal_id, :status, :private)
    end
end
