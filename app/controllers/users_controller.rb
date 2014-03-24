class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
  end

  def new
    @user = User.new
    render json: @user
  end

  def edit
  end

  def create
    @user=User.new(user_params)
    if @user.save
      render @user
    else
      render json: {errors: @user.errors user: @user}
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

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :provider, :password, :uid)
    end
end
