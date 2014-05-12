class Post < ActiveRecord::Base
  validates :user_step_id, :title, :comment, presence: true
  belongs_to :user_step
  has_one :user, through: :user_step
  has_one :goal, through: :user_step
  has_one :goal_step, through: :user_step


  def self.get_posts(_params)
    if _params[:goal_id].present?
      Post.joins(user_step: :goal_step).where(goal_steps: {goal_id: _params[:goal_id]})
    elsif _params[:user_id].present?
      Post.joins(:user_step).where(user_steps: {user_id: _params[:user_id]})
    elsif _params[:post_id].present?
      Post.find_by_id(_params[:post_id])
    else
      Post.all
    end
  end
end
