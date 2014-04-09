class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.get_users(params)
    render json: @users
  end

  def show
    render json: @user
  end

  def new
    @user = User.new
    render json: @user
  end

  def edit
    render json: @user
  end

  def create
    if User.save_user(user_params)
      render json: @user
    else
      render json: {errors: @user.errors}
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
    @user = User.get_user_random(random_params)
    render json: @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :provider, :password, :uid, :nickname,:image, :country, :description)
    end


    def login_params
      params.permit(:email, :password)
    end
    def random_params
      params.require(:goal_category_id)
    end
end
