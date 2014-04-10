class UserStep < ActiveRecord::Base
  validates :user_id, :goal_step_id, :status, presence: :true
  has_one :goal_step

  def self.get_user_steps(_params)
    if _params[:goal_id].present?
      user_steps = UserStep.where(goal_id: _params[:goal_id])
    elsif _params[:user_id].present?
      user_steps = UserStep.where(user_id: _params[:user_id])
    elsif _params[:user_step_id].present?
      user_steps = UserStep.find_by_id(_params[:user_step_id])
    else
      user_steps = UserStep.all
    end
  end
end
