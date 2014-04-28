class UserLevel < ActiveRecord::Base
  validates :user_id, :level_id, presence: true
  belongs_to :user
  belongs_to :level

  def self.get_user_levels(_params)
    if params[:user_level_id].present?
      UserLevel.find_by_id(_params[:user_level_id])
    elsif _params[:user_id].present?
      UserLevel.where(user_id: _params[:user_id])
    elsif _params[:level_id].present?
      UserLevel.where(level_id: _params[:level_id])
    else
      UserLevel.all
    end
  end
end
