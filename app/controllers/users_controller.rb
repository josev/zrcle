class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id].present?
      @users = User.find_by_id(user_id: params[:user_id])
    elsif params[:goal_id].present?
      @user_goals = UserGoal.select("user_id AS id").where(goal_id: params[:goal_id])
      if @user_goals.present?
        @users = User.where(id: @user_goals)
      end
    else
      @users = User.all
    end
    render json: @users
  end

  def show
    render json: @user
  end

  def new
    @user = User.new
    render json: @user
  end

  def edit
    render json: @user
  end

  def create
    @user=User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors}
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors
    end
  end

  def destroy
    if @user.destroy
      render text: "Deleted"
    else
      render json: @user.errors
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :provider, :password, :uid)
    end
end
