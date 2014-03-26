class CommentLikesController < ApplicationController
  before_action :set_comment_like, only: [:show, :edit, :update, :destroy]

  def index
    if params[:comment_id].present?
      @comment_likes = CommentLike.where(comment_id: params[:comment_id])
    elsif params[:user_id].present?
      @comment_likes = CommentLike.where(user_id: params[:user_id])
    elsif params[:comment_like_id].present?
      @comment_likes = CommentLike.fin_by_id(params[:comment_like_id])
    else
      @comment_likes = CommentLike.all
    end
    render json: @comment_likes
  end

  def show
    render json: @comment_likes
  end

  def new
    @comment_like = CommentLike.new
    render json: @comment_like
  end

  def edit
    render json: @comment_likes
  end

  def create
    @comment_like=CommentLike.new(user_params)
    if @comment_like.save
      render @comment_like
    else
      render json: {errors: @comment_like.errors}
    end
  end

  def update
    if @comment_like.update(comment_like_params)
      render json: @comment_like
    else
      render json: {errors: @comment_like.errors}
    end
  end

  def destroy
    if @comment_like.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @comment_like.errors}
    end
  end

  private
    def set_comment_like
      @comment_like = CommentLike.find_by_id(params[:id])
    end
    def comment_like_params
      params.require(:comment_like).permit(:comment_id, :user_id)
    end
end
