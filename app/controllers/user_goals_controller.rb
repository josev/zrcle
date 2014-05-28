class UserGoalsController < ApplicationController
  before_action :set_user_goal, only: [:show, :edit, :update, :destroy]
  before_action :set_user_goal_disable, only: [:disable_goal]
  before_action :set_user_goal_activate, only: [:create_by_goals, :create_by_users]

  def index
    @user_goals = UserGoal.get_user_goals(params)
    render json: @user_goals, root: false
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
      @user_goal.start_goal
      render json: @user_goal
    else
      render json: {errors: @user_goal.errors}
    end
  end

  def create_by_goals
    if @user_goal.present?
      if @user_goal.state == "0"
        @user_goal.state = "1"
        @user_goal.private = params[:private]
      else
        @user_goal.errors.add(:goal, "already have this goal")
        render json: {errors: @user_goal.errors}
        return
      end
    else
      @user_goal=UserGoal.new
      @user_goal.user_id = params[:user_id]
      @user_goal.goal_id = params[:goal_id]
      @user_goal.state = "1"
      @user_goal.private = params[:private]
    end
    if @user_goal.save
      @user_goal.start_goal
      render json: @user_goal
    else
      render json: {errors: @user_goal.errors}
    end
  end

  def create_by_users
    if @user_goal.present?
      if @user_goal.state == "0"
        @user_goal.state = "1"
        @user_goal.private = params[:private]
      else
        @user_goal.errors.add(:goal, "already have this goal")
        render json: {errors: @user_goal.errors}
        return
      end
    else
      @user_goal=UserGoal.new
      @user_goal.user_id = params[:user_id]
      @user_goal.goal_id = params[:goal_id]
      @user_goal.state = "1"
      @user_goal.private = params[:private]
    end
    if @user_goal.save
      @user_goal.start_goal
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

  def disable_goal
    @user_goal.state = 0 if @user_goal.present?
    if @user_goal.save
      render json: @user_goal
    else
      render json: {errors: @user_goal.errors}
    end
  end

  private
    def set_user_goal
      @user_goal = UserGoal.find_by_id(params[:id])
    end

    def set_user_goal_disable
      @user_goal = UserGoal.where(user_id: params[:user_id], goal_id: params[:goal_id]).first
    end

    def set_user_goal_activate
      @user_goal = UserGoal.where(user_id: params[:user_id], goal_id: params[:goal_id]).first
    end

    def user_goal_params
      params.require(:user_goal).permit(:user_id, :goal_id, :state, :private)
    end
end
