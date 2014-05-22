class UserStepsController < ApplicationController
  before_action :set_user_step, only: [:show, :edit, :update, :destroy]

  def index
    @user_steps = UserStep.get_user_steps(params)
    render json: @user_steps, root: false
  end

  def show
    render json: @user_step
  end

  def new
    @user_step = UserStep.new
    render json: @user_step
  end

  def edit
    render json: @goal_step
  end

  def create
    @user_step=UserStep.new(user_step_params)
    @user_step.date = Date.today
    if @user_step.save
      render json: @user_step
    else
      render json: {errors: @user_step.errors}
    end
  end

  def update
    if @user_step.update(user_step_params)
      render json: @user_step
    else
      render json: {errors: @user_step.errors}
    end
  end

  def destroy
    if @user_step.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @user_step.errors}
    end
  end

  def current_step
    @user_step = UserStep.current_step(current_step_params)
    render json: @user_step.present? ? @user_step : nil
  end

  def step_complete
    @next_step = UserStep.step_complete(current_step_params)
    if @next_step.present?
      if @next_step.errors.present?
        render json: {errors: @next_step.errors}
      else
        render json: @next_step
      end
    else
      render json: @next_step
    end
  end
  private
    def set_user_step
      @user_step = UserStep.find(params[:id])
    end

    def user_step_params
      params.require(:user_step).permit(:user_id, :goal_step_id, :status)
    end

    def current_step_params
      params.permit(:user_id, :goal_id)
    end
end
