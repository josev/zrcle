class FriendshipsController < ApplicationController
  before_action :set_frienship, only: [:show, :edit, :update, :destroy]

  def index
    @friendships = Friendship.get_frienships(params)
    render json: @friendships
  end

  def show
    render json: @friendships
  end

  def new
    @friendship = Friendship.new
    render json: @friendship
  end

  def edit
    render json: @friendships
  end

  def create
    @friendship=Friendship.new(friendship_params)
    if @friendship.save
      render json: @friendship
    else
      render json: {errors: @friendship.errors}
    end
  end

  def update
    if @friendship.update(friendship_params)
      render json: @friendship
    else
      render json: {errors: @friendship.errors}
    end
  end

  def destroy
    if @friendship.destroy
      render text: "Deleted"
    else
      render json: {errors: @friendship.errors}
    end
  end

  private
    def set_friendship
      @friendship = Friendship.find_by_id(params[:id])
    end

    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :status)
    end
end
