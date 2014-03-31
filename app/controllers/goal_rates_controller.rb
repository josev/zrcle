class GoalRatesController < ApplicationController
  before_action :set_goal_rate, only: [:show, :edit, :update, :destroy]

  def index
    @goal_rates = GoalRate.get_goal_rates(params)
    render json: @goal_rates
  end

  def show
    render json: @goal_rates
  end

  def new
    @goal_rate = GoalRate.new
    render json: @goal_rate
  end

  def edit
    render json: @goal_rates
  end

  def create
    @goal_rate=GoalRate.new(goal_rate_params)
    if @goal_rate.save
      render json: @goal_rate
    else
      render json: {errors: @goal_rate.errors}
    end
  end

  def update
    if @goal_rate.update(goal_rate_params)
      render json: @goal_rate
    else
      render json: {errors: @goal_rate.errors}
    end
  end

  def destroy
    if @goal_rate.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @goal_rate.errors}
    end
  end

  private
    def set_goal_rate
      @goal_rate = GoalRate.find_by_id(params[:id])
    end

    def goal_rate_params
      params.require(:goal_rate).permit(:user_id, :goal_id, :rate)
    end
end
