class Comment < ActiveRecord::Base
    validates :goal_id, :user_id, :comment, :date, presence: true
    belongs_to :goal
    belongs_to :user
    
    def self.get_comments(_params)
    if _params[:goal_id].present?
      comments = Comment.where(goal_id: _params[:goal_id])
    elsif _params[:user_id].present?
      comments = Comment.where(user_id: _params[:user_id])
    elsif _params[:comment_id].present?
      comments = Comment.find_by_id(_params[:comment_id])
    else
      comments = Comment.all
    end
  end
end
