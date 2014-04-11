class User < ActiveRecord::Base
  validates :nickname, presence: :true
  validates_uniqueness_of :email
  has_many :user_goals
  has_one :user_configurations
  has_one :profile

  accepts_nested_attributes_for :profile

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
    if _params[:provider]=='facebook'
      user = User.where(email: _params[:email]).first
      if user.present?
        user.oauth_token = _params[:oauth_token]
        user.uid = _params[:uid]
      end
    else
      user = User.where(email: _params[:email], password: _params[:password]).first
    end
    if user.present?
      user.provider=_params[:provider]
      user.save
      login = true
      Array({:login => login,:user => user,:errors => user.errors})
    else
      login= false
      Array({:login => login,:user => user})
    end
  end

  def self.get_user_random(goal_category_id)
    goals = Goal.select("id").where(goal_category_id: goal_category_id)
    user_goals = UserGoal.select("user_id").where(goal_id: goals).group("user_id")
    r = user_goals.shuffle
    user= User.where(id: r.first.user_id)
  end

  def save_user(_params)
    u = User.new
    if _params[:provider] == "facebook"
      if _params[:uid] == nil || _params[:uid] == ""
        u.errors.add(:uid,"Error uid can't be null or empty")
        return u
      else
        if User.where(uid: _params[:uid]).present?
          u.errors.add(:uid,"Error the uid already exists")
          return u
        end
      end
    end
    u.attributes = _params.reject{|k,v| !u.attributes.keys.member?(k.to_s)}
    u.image = nil
    if u.save
      p = Profile.new
      p.attributes = _params.reject{|k,v| !p.attributes.keys.member?(k.to_s)}
      p.user_id = u.id
      p.date = Date.today
      if !p.save
        self.errors.add(:profile,p.errors)
      end
    else
      self.errors.add(:user,u.errors)
    end
    u
  end

  def self.get_user(user)
    u =User.joins("full outer join profiles on users.id = profiles.user_id").where("users.id=#{user.id}")
    u.select("users.id, users.email, users.provider,users.password, users.image, users.uid, profiles.country, profiles.description")
  end
end
