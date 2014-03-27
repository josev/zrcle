class UserGoalsController < ApplicationController
  before_action :set_user_goal, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_goal_id].present?
      @user_goals = UserGoal.find_by_id(params[:user_goal_id])
    elsif params[:user_id].present?
      @user_goals = UserGoal.where(user_id: params[:user_id])
    elsif params[:goal_id].present?
      @user_goals = UserGoal.where(goal_id: params[:goal_id])
    else
      @user_goals = UserGoal.all
    end
    render json: @user_goals
  end

  def show
    render json: @user_goal
  end

  def new
    @user_goal = UserGoal.new
    render json: @user_goal
  end

  def edit
    render json: @user_goal
  end

  def create
    @user_goal=UserGoal.new(user_goal_params)
    if @user_goal.save
      render json: @user_goal
    else
      render json: {errors: @user_goal.errors}
    end
  end

  def create_by_goals
    @user_goal=UserGoal.new
    @user_goal.user_id = params[:id]
    @user_goal.goal_id = params[:goal_id]
    @user_goal.state = "1"
    if @user_goal.save
      render json: @user_goal
    else
      render json: {errors: @user_goal.errors}
    end
  end

  def create_by_users
    @user_goal=UserGoal.new
    @user_goal.user_id = params[:user_id]
    @user_goal.goal_id = params[:id]
    @user_goal.state = "1"
    if @user_goal.save
      render json: @user_goal
    else
      render json: {errors: @user_goal.errors}
    end
  end

  def update
    if @user_goal.update(user_goal_params)
      render json: @user_goal
    else
      render json: {errors: @user_goal.errors}
    end
  end

  def destroy
    if @user_goal.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @user_goal.errors}
    end
  end

  private
    def set_user_goal
      @user_goal = UserGoal.find_by_id(params[:id])
    end

    def user_goal_params
      params.require(:user_goal).permit(:user_id, :goal_id, :state, :private)
    end
end
