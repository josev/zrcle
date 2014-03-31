class CommentLike < ActiveRecord::Base
  validates :comment_id, :user_id, presence: true
  belongs_to :comment 
  belongs_to :user

  def self.get_comment_likes(_params)
    if _params[:comment_id].present?
      comment_likes = CommentLike.where(comment_id: _params[:comment_id])
    elsif _params[:user_id].present?
      comment_likes = CommentLike.where(user_id: _params[:user_id])
    elsif _params[:comment_like_id].present?
      comment_likes = CommentLike.fin_by_id(_params[:comment_like_id])
    else
      comment_likes = CommentLike.all
    end
  end
end
