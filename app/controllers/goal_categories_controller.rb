class GoalCategoriesController < ApplicationController
	before_action :set_goal_category, only: [:update, :destroy]

  def index
    @goal_categories = GoalCategory.all
    render json: @goal_categories
  end

  def show
  end

  def new
    @goal_category = GoalCategory.new
    render json: @goal_category
  end

  def edit
  end

  def create
    @goal_category=GoalCategory.new(goal_category_params)
    if @goal_category.save
      render @goal_category
    else
      render json: @goal_category.errors
    end
  end

  def update
    if @goal_category.update(goal_category_params)
      render json: @goal_category
    else
      render json: @goal_category.errors
    end
  end

  def destroy
    if @goal_category.destroy
      render text: "Deleted"
    else
      render json: @goal_category.errors
    end
  end

  private
    def set_goal_category
      @goal_category = GoalCategory.find(params[:id])
    end

    def goal_category_params
      params.require(:goal_category).permit(:name)
    end
end
