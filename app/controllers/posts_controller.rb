class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

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

  private
    def set_post
      @post = Post.find_by_id(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :comment, :image)
    end
end

