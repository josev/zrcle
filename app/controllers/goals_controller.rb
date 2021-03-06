class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :goal_image, :get_users_by_goal, :motivationals, :motivationals_by_user]
  before_action :set_user, only: [:get_users_by_goal]

  def index
    @goals = Goal.get_goals(params)
    render json: @goals, root: false
  end

  def show
    render json: @goal, root: false
  end

  def default_serializer_options
    user_id= params[:user_id] if params[:user_id].present?  
    {root: false, user_id: user_id, except: [:password, :provider, :uid, :oauth_token, :country, :description, :follows, :friends, :finishied_goals, :goals, :goals_ids]}  
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

  def goal_image
    @goal.image = upload_params
    if @goal.save
      render json: @goal
    else
      render json: {errors: @goal.errors}
    end
  end

  def get_users_by_goal
    @users = @goal.get_users_by_goal(@user)
    render json: @users
  end

  def motivationals
    render json: @goal.motivationals
  end

  def motivationals_by_user
    render json: @goal.motivationals_by_user(params[:user_id])
  end

  private
    def set_goal
      @goal = Goal.find_by_id(params[:id])
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def goal_params
      params.require(:goal).permit(:name, :description, :image, :goal_category_id, :expected_result, :date, :goal_type_id)
    end

    def upload_params
      params.require(:image)
    end

    def search_params
      params.require(:text)
    end
end
