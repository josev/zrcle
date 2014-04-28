class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
    @user = User.get_user_random(random_params)
    render json: @user
  end

  def user_image
    uploaded_io = upload_params
    if uploaded_io!=nil
      tmp_string = "#{@user.id}-#{@user.name}"
      if File.exist?("public/images/users/#{tmp_string}.jpg")
        File.delete("public/images/users/#{tmp_string}.jpg")
      end
      File.new("public/images/users/#{tmp_string}.jpg","w")
      File.open(Rails.root.join('public/images/', 'users', "#{tmp_string}.jpg"), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      
      tmp_string = tmp_string.gsub(" ","%20")
      @user.image = "http://zircle.herokuapp.com/images/users/#{tmp_string}.jpg"
      if @user.save
        render json: {url: @user.image}
      else
        render json: {errors: @user.errors}
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :provider, :password, :uid, :nickname,:image, :country, :description)
    end


    def login_params
      params.require(:login).permit(:email, :password, :provider, :oauth_token, :uid)
    end
    def random_params
      params.require(:goal_category_id)
    end
end
