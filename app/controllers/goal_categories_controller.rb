class GoalCategoriesController < ApplicationController
	before_action :set_goal_category, only: [:show, :edit, :update, :destroy]

  def index
    if params[:goal_category_id].present?
      @goal_categories = GoalCategory.find_by_id(params[:goal_category_id])
    elsif params[:goal_id].present?
      @goal = Goal.find_by_id(params[:goal_id])
      @goal_categories = @goal.goal_category
    else
      @goal_categories = GoalCategory.all
    end
    render json: @goal_categories
  end

  def show
    render json: @goal_categories
  end

  def new
    @goal_category = GoalCategory.new
    render json: @goal_category
  end

  def edit
    render json: @goal_categories
  end

  def create
    @goal_category=GoalCategory.new(goal_category_params)
    if @goal_category.save
      render json: @goal_category
    else
      render json: {errors: @goal_category.errors}
    end
  end

  def update
    if @goal_category.update(goal_category_params)
      render json: @goal_category
    else
      render json: {errors: @goal_category.errors}
    end
  end

  def destroy
    if @goal_category.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @goal_category.errors}
    end
  end

  private
    def set_goal_category
      @goal_category = GoalCategory.find_by_id(params[:id])
    end

    def goal_category_params
      params.require(:goal_category).permit(:name)
    end
end
