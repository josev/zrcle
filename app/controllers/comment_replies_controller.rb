class CommentRepliesController < ApplicationController
	before_action :set_comment_reply, only: [:show, :edit, :update, :destroy]

  def index
    if params[:comment_id].present?
      @comment_replies = CommentReply.where(comment_id: params[:comment_id])
    elsif params[:user_id].present?
      @comment_replies = CommentReply.where(user_id: params[:user_id])
    elsif params[:comment_reply_id].present?
      @comment_replies = CommentReply.find_by_id(params[:comment_reply_id])
    else
      @comment_replies = CommentReply.all
    end
    render json: @comment_replies
  end

  def show
    render json: @comment_replies
  end

  def new
    @comment_reply = CommentReply.new
    render json: @comment_reply
  end

  def edit
    render json: @comment_replies
  end

  def create
    @comment_reply=CommentReply.new(comment_reply_params)
    if @comment_reply.save
      render @comment_reply
    else
      render json: {errors: @comment_reply.errors}
    end
  end

  def update
    if @comment_reply.update(comment_reply_params)
      render json: @comment_reply
    else
      render json: {errors: @comment_reply.errors}
    end
  end

  def destroy
    if @comment_reply.destroy
      render json: {text: "Deleted"}
    else
      render json: {errors: @comment_reply.errors}
    end
  end

  private
  	def set_comment_reply
  		@comment_reply = CommentReply.find(params[:id])
  	end
    def comment_reply_params
      params.require(:comment_reply).permit(:comment_id, :user_id, :comment)
    end
end
