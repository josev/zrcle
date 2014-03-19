class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  
  def index
    @goals = Goal.all
    render json: @goals
  end

  def show
  end

  def new
    @goal= Goal.new
    render json: @goal
  end

  def edit
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      render json: @goal
    else
      render json: @goal.errors
    end
  end

  def update
  end

  def destroy
  end

  private
    def set_goal
      @goal = Goal.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:name, :description, :image, :goal_category_id, :expected_result, :date, :type_id)
    end
end
