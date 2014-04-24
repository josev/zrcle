class UserStep < ActiveRecord::Base
  validates :user_id, :goal_step_id, :status, presence: :true
  belongs_to :goal_step

  def self.get_user_steps(_params)
    if _params[:goal_id].present?
      UserStep.where(goal_id: _params[:goal_id])
    elsif _params[:user_id].present?
      UserStep.where(user_id: _params[:user_id])
    elsif _params[:user_step_id].present?
      UserStep.find_by_id(_params[:user_step_id])
    else
      UserStep.all
    end
  end

  def self.current_step(_params)
    g = Goal.find_by_id(_params[:goal_id])
    g.current_step(_params[:user_id]).present? ? g.current_step(_params[:user_id]) : nil
  end
end
