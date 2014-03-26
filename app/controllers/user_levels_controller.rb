class UserLevelsController < ApplicationController
  before_action :set_user_level, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_level_id].present?
      @user_levels = UserLevel.find_by_id(params[:user_level_id])
    elsif params[:user_id].present?
      @user_levels = UserLevel.where(user_id: params[:user_id])
    elsif params[:level_id].present?
      @user_levels = UserLevel.where(level_id: params[:level_id])
    else
      @user_levels = UserLevel.all
    end
    render json: @user_levels
  end

  def show
    render json: @user_level
  end

  def new
    @user_level = UserLevel.new
    render json: @user_level
  end

  def edit
    render json: @user_level
  end

  def create
    @user_level=UserLevel.new(user_level_params)
    if @user_level.save
      render json: @user_level
    else
      render json: {errors: @user_level.errors}
    end
  end

  def update
    if @user_level.update(user_level_params)
      render json: @user_level
    else
      render json: {errors: @user_level.errors}
    end
  end

  def destroy
    if @user_level.destroy
      render text: "Deleted"
    else
      render json: {errors: @user_level.errors}
    end
  end

  private
    def set_user_level
      @user_level = UserLevel.find_by_id(params[:id])
    end

    def user_level_params
      params.require(:user_level).permit(:user_id, :level_id, :points)
    end
end
