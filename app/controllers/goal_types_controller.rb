class GoalTypesController < ApplicationController
  before_action :set_goal_type, only: [:show, :edit, :update, :destroy]

  def index
    if params[:goal_id].present?
      @goal = Goal.find_by_id(params["goal_id"])
      @goal_types = @goal.goal_type
    else
      @goal_types = GoalType.all
    end
    render json: @goal_types
  end

  def show
    render json: @goal_type
  end

  def new
    @goal_type = GoalType.new
    render json: @goal_type
  end

  def edit
    render json: @goal_type
  end

  def create
    @goal_type=GoalType.new(goal_type_params)
    if @goal_type.save
      render json: @goal_type
    else
      render json: {errors: @goal_type.errors}
    end
  end

  def update
    if @goal_type.update(goal_type_params)
      render json: @goal_type
    else
      render json: {errors: @goal_type.errors}
    end
  end

  def destroy
    if @goal_type.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @goal_type.errors}
    end
  end

  private
    def set_goal_type
      @goal_type = GoalType.find(params[:id])
    end

    def goal_type_params
      params.require(:goal_type).permit(:name)
    end
end
