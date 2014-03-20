class LevelsController < ApplicationController
	before_action :set_level, only: [:update, :destroy]

  def index
    @levels = Level.all
    render json: @levels
  end

  def show
  end

  def new
    @level = Level.new
    render json: @level
  end

  def edit
  end

  def create
    @level=Level.new(level_params)
    if @level.save
      render @level
    else
      render json: @level.errors
    end
  end

  def update
    if @level.update(level_params)
      render json: @level
    else
      render json: @level.errors
    end
  end

  def destroy
    if @level.destroy
      render text: "Deleted"
    else
      render json: @level.errors
    end
  end

  private
    def set_level
      @level = Level.find(params[:id])
    end

    def level_params
      params.require(:level).permit(:level_number,:required_points)
    end
end
