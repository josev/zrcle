class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:goal_type_id].present?
      @goals = Goal.where(goal_type_id: params[:goal_type_id])
    elsif params[:goal_category_id].present?
      @goals = Goal.where(goal_category_id: params[:goal_category_id])
    else
      @goals = Goal.all
    end
    render json: @goals
  end

  def show
    render json: @goal
  end

  def new
    @goal= Goal.new
    render json: @goal
  end

  def edit
    render json: @goal
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.date= DateTime.now
    if @goal.save
      render json: @goal
    else
      render json: {errors: @goal.errors}
    end
  end

  def update
    if @goal.update(goal_params)
      render json: @goal
    else
      render json: {errors: @goal.errors}
    end
  end

  def destroy
    if @goal.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @goal.errors}
    end
  end

  private
    def set_goal
      @goal = Goal.find_by_id(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:name, :description, :image, :goal_category_id, :expected_result, :date, :goal_type_id)
    end
end
