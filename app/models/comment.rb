class Comment < ActiveRecord::Base
    validates :goal_id, :user_id, :comment, presence: true
    belongs_to :goal
    belongs_to :user
    after_create :add_points
    
  def self.get_comments(_params)
    if _params[:goal_id].present?
      #Comment.joins("full outer join user_goals on comments.user_id = user_goals.user_id and comments.goal_id = user_goals.goal_id").where("user_goals.private = false and comments.goal_id = #{_params[:goal_id]} and comments.to_user_id is null")
      Comment.joins("join user_goals on comments.user_id = user_goals.user_id and comments.goal_id = user_goals.goal_id").where(user_goals: {private: false}, goal_id: _params[:goal_id], to_user_id: nil)
    elsif _params[:user_id].present?
      Comment.where(user_id: _params[:user_id])
    elsif _params[:comment_id].present?
      Comment.find_by_id(_params[:comment_id])
    else
      Comment.all
    end
  end

  def self.get_motivational_sent(user)
    Comment.where(user_id: user.id).where.not(to_user_id: nil)
  end

  def self.get_motivational_received(user)
    Comment.where(to_user_id: user.id).where.not(user_id: nil)
  end

  protected
    def add_points
      if self.to_user_id.present?
        self.user.user_level.add_points(50)
      end
    end
end
