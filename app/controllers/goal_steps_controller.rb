class GoalStepsController < ApplicationController
  before_action :set_goal_step, only: [:show, :edit, :update, :destroy]

  def index
    @goal_steps = GoalStep.get_goal_steps(params)
    render json: @goal_steps
  end

  def show
    render json: @goal_step
  end

  def new
    @goal_step = GoalStep.new
    render json: @goal_step
  end

  def edit
    render json: @goal_step
  end

  def create
    @goal_step=GoalStep.new(goal_step_params)
    if @goal_step.save
      render json: @goal_step
    else
      render json: {errors: @goal_step.errors}
    end
  end

  def update
    if @goal_step.update(goal_step_params)
      render json: @goal_step
    else
      render json: {errors: @goal_step.errors}
    end
  end

  def destroy
    if @goal_step.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @goal_step.errors}
    end
  end

  private
    def set_goal_step
      @goal_step = GoalStep.find(params[:id])
    end

    def goal_step_params
      params.require(:goal_step).permit(:goal_id, :description,:title, :order)
    end
end
