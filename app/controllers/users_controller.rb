class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :random_user, :user_image, :edit_user, :goals_complete]

  def index
    @users = User.get_users(params)
    render json: @users, root: false
  end

  def show
    render json: @user, except: :password
  end

  def new
    @user = User.new
    render json: @user
  end

  def edit
    render json: @user
  end

  def create
    @user = User.new
    @user = @user.save_user(user_params)
    if @user.errors.present?
      render json: {errors: @user.errors}
    else
      render json: @user
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors
    end
  end

  def destroy
    if @user.destroy
      render text: "Deleted"
    else
      render json: @user.errors
    end
  end
  def login
    @user = User.login(login_params)
    render json: @user
  end

  def random_user
    @r_user = User.get_user_random(@user)
    render json: @r_user
  end

  def user_image
    @user.image = upload_params
    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors}
    end
  end

  def edit_user
    @user.edit_user(@user, @user.profile, user_params)
    if !@user.errors.present?
      render json: @user
    else
      render json: {errors: @user.errors}
    end
  end

  def goals_complete
    @goals = Array.new
    @user.finishied_goals.each do |g|
      @goals.push(g.goal)
    end
    render json: @goals
  end

  def see_goals_user
    @goals = User.see_goals_user(params[:id])
    render json: @goals
  end

  def see_completes_goals_user
    @goals = User.see_completes_goals_user(params[:id])
    render json: @goals
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :provider, :password, :uid, :nickname, :country, :description)
    end

    def login_params
      params.require(:login).permit(:email, :password, :provider, :oauth_token, :uid)
    end

    def upload_params
      params.require(:image)
    end
end
