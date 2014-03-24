class ProfilesController < ApplicationController
  before_action :set_profile, only: [:update, :destroy]

  def index
    @profiles = Profile.all
    render json: @profiles
  end

  def show
  end

  def new
    @profile = Profile.new
    render json: @profile
  end

  def edit
  end

  def create
    @profile=Profile.new(profile_params)
    if @profile.save
      render @profile
    else
      render json: @profile.errors
    end
  end

  def update
    if @profile.update(profile_params)
      render json: @profile
    else
      render json: @profile.errors
    end
  end

  def destroy
    if @profile.destroy
      render text: "Deleted"
    else
      render json: @profile.errors
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:name, :last_name, :date)
    end
end
