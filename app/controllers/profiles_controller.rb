class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    if params[:profile_id].present?
      @profiles = Profile.find_by_id(params[:profile_id])
    elsif params[:user_id].present?
      @profiles = Profile.where(user_id: params[:user_id])
    else
      @profiles = Profile.all
    end
    render json: @profiles
  end

  def show
    render json: @profile
  end

  def new
    @profile = Profile.new
    render json: @profile
  end

  def edit
    render json: @profile
  end

  def create
    @profile=Profile.new(profile_params)
    if @profile.save
      render json: @profile
    else
      render json: {errors: @profile.errors}
    end
  end

  def update
    if @profile.update(profile_params)
      render json: @profile
    else
      render json: {errors: @profile.errors}
    end
  end

  def destroy
    if @profile.destroy
      render text: "Deleted"
    else
      render json: {errors: @profile.errors}
    end
  end

  private
    def set_profile
      @profile = Profile.find_by_id(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:name, :last_name, :date)
    end
end
