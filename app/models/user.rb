class User < ActiveRecord::Base
  validates :nickname, presence: :true
  validates_uniqueness_of :email
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

  def self.login(_params)
    user = User.where(email: _params[:email], password: _params[:password])
    login = user.present?
    vars = Array({:login => login,:user => user})
  end

  def self.get_user_random(goal_category_id)
    goals = Goal.select("id").where(goal_category_id: goal_category_id)
    user_goals = UserGoal.select("user_id").where(goal_id: goals).group("user_id")
    r = user_goals.shuffle
    user= User.where(id: r.first.user_id)
  end

  def self.save_user(_params)
     u = User.new
     u.attributes = _params.reject{|k,v| !u.attributes.keys.member?(k.to_s)}
     u.image = nil
     if u.save
      p = Profile.new
      p.attributes = _params.reject{|k,v| !p.attributes.keys.member?(k.to_s)}
      p.user_id = u.id
      p.save
     end
  end
end
