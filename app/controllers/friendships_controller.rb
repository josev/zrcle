class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:get_friends_by_goal]

  def default_serializer_options
    {root: false, except: [:password, :provider, :uid, :oauth_token, :country, :description, :follows, :friends, :finishied_goals, :goals, :goals_ids]}
  end

  def index
    @friendships = Friendship.get_friendships(params)
    render json: @friendships, root: false
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
    @friendship.status = 2
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

  def get_friends
    @friends = Friendship.get_friends(get_friends_params)
    render json: @friends
  end

  def get_friends_by_name
    @friends = Friendship.get_friends_by_name(get_friends_params,search_params)
    render json: @friends
  end

  def get_friends_by_goal
    @friends = Friendship.get_friends_by_goal(@user, params[:goal_id])
    render json: @friends
  end

  def requests_friend_received
    @friendships = Friendship.requests_friend_received(params[:user_id])
    render json: @friendships, root: false
  end

  def requests_friend_sent
    @friendships = Friendship.requests_friend_sent(params[:user_id])
    render json: @friendships, root: false
  end

  private
    def set_friendship
      @friendship = Friendship.find_by_id(params[:id])
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :status)
    end

    def get_friends_params
      params.require(:user_id)
    end

    def search_params
      params.require(:text)
    end
end
