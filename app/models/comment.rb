class Comment < ActiveRecord::Base
    validates :goal_id, :user_id, :comment, :date, presence: true
    belongs_to :goal
    belongs_to :user
    
    def self.get_comments(_params)
    if _params[:goal_id].present?
      Comment.where(goal_id: _params[:goal_id])
    elsif _params[:user_id].present?
      Comment.where(user_id: _params[:user_id])
    elsif _params[:comment_id].present?
      Comment.find_by_id(_params[:comment_id])
    else
      Comment.all
    end
  end
end
