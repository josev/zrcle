class FollowUsersController < ApplicationController
  before_action :set_follow_user, only: [:update, :destroy]

  def index
    @follow_users = FollowUser.all
    render json: @follow_users
  end

  def show
  end

  def new
    @follow_user = FollowUser.new
    render json: @follow_user
  end

  def edit
  end

  def create
    @follow_user=FollowUser.new(follow_user_params)
    if @follow_user.save
      render @follow_user
    else
      render json: @follow_user.errors
    end
  end

  def update
    if @follow_user.update(follow_user_params)
      render json: @follow_user
    else
      render json: @follow_user.errors
    end
  end

  def destroy
    if @follow_user.destroy
      render text: "Deleted"
    else
      render json: @follow_user.errors
    end
  end

  private
    def set_follow_user
      @follow_user = FollowUser.find(params[:id])
    end

    def follow_user_params
      params.require(:follow_user).permit(:user_id, :follow_user_id, :status)
    end
end
