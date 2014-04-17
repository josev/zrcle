class User < ActiveRecord::Base
  validates :nickname, presence: :true
  validates_uniqueness_of :email
  has_one :user_configurations
  has_one :profile
  has_many :goals, through: :user_goals

  accepts_nested_attributes_for :profile

  def self.goals
    UserGoal.where(user_id: self.id)
  end

  def self.get_users(_params)
    if _params[:user_id].present?
      User.find_by_id(user_id: _params[:user_id])
    elsif _params[:goal_id].present?
      user_goals = UserGoal.select("user_id AS id").where(goal_id: _params[:goal_id])
      if user_goals.present?
        User.where(id: user_goals)
      end
    else
      User.all
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
    end
    user
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

  def following_me
    FollowUser.where(follow_user_id: self.id)
  end

  def profile
    Profile.where(user_id: self.id).first
  end

  def friends
    friends = Friendship.where("user_id = #{self.id} or friend_id = #{self.id}")
    lst = Array.new
    lst = friends.select("friend_id as id").where(user_id: self.id)
    lst += friends.select("user_id as id").where(friend_id: self.id)
    users = User.where(id: lst)
  end

  def goals
    UserGoal.where(user_id: self.id)
  end
end
