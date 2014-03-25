class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    render json: @comments
  end

  def new
    @comment = Comment.new
    render json: @comment
  end

  def edit
    render json: @comments
  end

  def create
    @comment=Comment.new(comment_params)
    if @comment.save
      render @comment
    else
      render json: @comment.errors
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors
    end
  end

  def destroy
    if @comment.destroy
      render text: "Deleted"
    else
      render json: @comment.errors
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:goal_id, :user_id, :to_user_id,:comment)
    end
end
