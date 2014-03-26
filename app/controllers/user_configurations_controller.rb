class UserConfigurationsController < ApplicationController
  before_action :set_user_configuration, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_configuration_id].present?
      @user_configurations = UserConfiguration.find_by_id(params[:user_configuration_id])
    elsif params[:user_id].present?
      @user_configurations = UserConfiguration.where(user_id: params[:user_id])
    else
      @user_configurations = UserConfiguration.all
    end
    render json: @user_configurations
  end

  def show
    render json: @user_configuration
  end

  def new
    @user_configuration = UserConfiguration.new
    render json: @user_configuration
  end

  def edit
    render json: @user_configuration
  end

  def create
    @user_configuration=UserConfiguration.new(user_configuration_params)
    if @user_configuration.save
      render json: @user_configuration
    else
      render json: {errors: @user_configuration.errors}
    end
  end

  def update
    if @user_configuration.update(user_configuration_params)
      render json: @user_configuration
    else
      render json: {errors: @user_configuration.errors}
    end
  end

  def destroy
    if @user_configuration.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @user_configuration.errors}
    end
  end

  private
    def set_user_configuration
      @user_configuration = UserConfiguration.find_by_id(params[:id])
    end

    def user_configuration_params
      params.require(:user_configuration).permit(:user_id, :notification, :new_message, :new_follower, :replies, :likes)
    end
end
