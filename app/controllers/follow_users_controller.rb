class FollowUsersController < ApplicationController
  before_action :set_follow_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:follows, :follow_me]
  before_action :find_follow, only: [:create]

  def default_serializer_options
    user_id= params[:user_id] if params[:user_id].present?  
    {root: false, user_id: user_id, except: [:password, :provider, :uid, :oauth_token, :country, :description, :follows, :friends, :finishied_goals, :goals, :goals_ids]}  
  end  

  def index
    @follow_users = FollowUser.get_follow_users(params)
    render json: @follow_users, root: false
  end

  def show
    render json: @follow_users
  end

  def new
    @follow_user = FollowUser.new
    render json: @follow_user
  end

  def edit
    render json: @follow_users
  end

  def create
    if !@follow_user.present?
      @follow_user=FollowUser.new(follow_user_params)
    else
      @follow_user.status = 1
    end
    if @follow_user.save
      render json: @follow_user
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

  def follows
    @users = FollowUser.follows(@user)
    render json: @users
  end

  def follow_me
    @users = FollowUser.follow_me(@user)
    render json: @users
  end

  def unfollow_user
    @follow = FollowUser.unfollow_user(params[:user_id], params[:follow_user_id])
    render json: @follow
  end
  private
    def set_follow_user
      @follow_user = FollowUser.find(params[:id])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def find_follow
      @follow_user = FollowUser.where(user_id: follow_user_params[:user_id], follow_user_id: follow_user_params[:follow_user_id]).first
    end

    def follow_user_params
      params.require(:follow_user).permit(:user_id, :follow_user_id, :status)
    end
end
