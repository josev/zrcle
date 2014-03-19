class UserController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  def index
  end

  def show
  end

  def new
    @user = Employee.new
  end

  def edit
  end

  def create
    @user=User.new(user_params)
    respond_to do |format|
      if @user.save
        format.json{ render text: "Saved" }
      else
        format.json{ render text: "#{@user.errors}" }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json{ render text: "Updated"}
      else
        format.jason{ render text: "#{@user.errors}"}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.json{render text: "Deleted"}
      else
        formatjson{render text: "#{@user.errors}"}
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :lastname, :email. :provider, :password)
    end
end
