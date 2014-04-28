class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  
  def index
    @goals = Goal.get_goals(params)
    render json: @goals, root: false
  end

  def show
    render json: @goal
  end

  def default_serializer_options
    user_id= params[:user_id] if params[:user_id].present?  
    {user_id: user_id}  
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

  def search_by_name
    @goals = Goal.search_by_name(search_params)
    render json: @goals, root: false
  end

  def search_by_category
    @goals = Goal.search_by_category(search_params)
    render json: @goals
  end

  private
    def set_goal
      @goal = Goal.find_by_id(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:name, :description, :image, :goal_category_id, :expected_result, :date, :goal_type_id)
    end

    def search_params
      params.require(:text)
    end
end
