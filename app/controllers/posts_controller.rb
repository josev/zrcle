class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:get_timeline]
  before_action :set_goal, only: [:get_timeline, :get_timeline_goal]

  def index
    @posts = Post.get_posts(params)
    render json: @posts, root: false
  end

  def show
    render json: @post
  end

  def new
    @post = Post.new
    render json: @post
  end

  def edit
    render json: @post
  end

  def create
    @post=Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: {errors: @post.errors}
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: {errors: @post.errors}
    end
  end

  def destroy
    if @post.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @post.errors}
    end
  end

  def get_timeline
    @timeline = Post.get_timeline(@user, @goal)
    render json: @timeline
  end

  def get_timeline_goal
    @timeline = Post.get_timeline_goal(@goal)
    render json: @timeline
  end

  private
    def set_post
      @post = Post.find_by_id(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_goal
      @goal = Goal.find(params[:goal_id])
    end

    def post_params
      params.require(:post).permit(:title, :comment, :image)
    end
end

