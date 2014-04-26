class GoalCategoriesController < ApplicationController
	before_action :set_goal_category, only: [:show, :edit, :update, :destroy, :category_image]

  def index
    @goal_categories = GoalCategory.get_goal_categories(params)
    render json: @goal_categories, root: false
  end

  def show
    render json: @goal_category
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

  def category_image
    uploaded_io = upload_params
    if uploaded_io!=nil
      tmp_string = "#{@goal_category.id}-#{@goal_category.name}"
      if File.exist?("public/images/categories/#{tmp_string}.png")
        File.delete("public/images/categories/#{tmp_string}.png")
      end
      File.open(Rails.root.join('public/images/', 'categories', "#{tmp_string}.png"), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @goal_category.image = "http://zircle.herokuapp.com/images/categories/#{tmp_string}.png"
      if @goal_category.save
        render json: {url: @goal_category.image}
      else
        render json: {errors: @goal_category.errors}
      end
    end
  end

  private
    def set_goal_category
      @goal_category = GoalCategory.find_by_id(params[:id])
    end

    def goal_category_params
      params.require(:goal_category).permit(:name, :image)
    end

    def upload_params
      params.require(:image)
    end
end
