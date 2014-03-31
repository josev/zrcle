class CommentReply < ActiveRecord::Base
  validates :comment_id, :user_id, :comment, :date, presence: true
  belongs_to :comment
  belongs_to :user

  def get_comment_replies(_params)
    if _params[:comment_id].present?
      comment_replies = CommentReply.where(comment_id: _params[:comment_id])
    elsif _params[:user_id].present?
      comment_replies = CommentReply.where(user_id: _params[:user_id])
    elsif _params[:comment_reply_id].present?
      comment_replies = CommentReply.find_by_id(_params[:comment_reply_id])
    else
      comment_replies = CommentReply.all
    end
  end
end
