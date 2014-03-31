class User < ActiveRecord::Base
  validates_uniqueness_of :email, :uid
  has_many :user_goals
  has_one :user_configurations
  has_one :profile
  def self.goals
    UserGoal.where(user_id: self.id)
  end

  def self.get_users(_params)
    if _params[:user_id].present?
      users = User.find_by_id(user_id: _params[:user_id])
    elsif _params[:goal_id].present?
      user_goals = UserGoal.select("user_id AS id").where(goal_id: _params[:goal_id])
      if user_goals.present?
        users = User.where(id: user_goals)
      end
    else
      users = User.all
    end
  end
end
