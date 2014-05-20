class User < ActiveRecord::Base
  validates :nickname, presence: :true
  after_create :create_lvl
  validates_uniqueness_of :email
  has_one :user_configurations
  has_one :profile
  has_one :user_level
  has_one :level, through: :user_level
  has_many :goals, through: :user_goals
  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :profile

  def goals
    UserGoal.where(user_id: self.id, state: ["1","2"])
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

  def self.get_user_random(user)
    u_categories = Array.new
    if user.goals.present?
      user.goals.each do |g|
        if g.goal.present?
          u_categories.push(g.goal.goal_category_id)
        end
      end
    else
      GoalCategory.all.each do |c|
        u_categories.push(c.id)
      end
    end
    goal_category_id = u_categories.shuffle
    goals = Goal.select("id").where(goal_category_id: goal_category_id)
    user_goals = UserGoal.where(goal_id: goals, private: false).where.not(user_id: user.id)
    r = user_goals.shuffle
    if r.present?
      r_user = User.where(id: r.first.user_id).first
      random = Random.new(r.first.goal_id, r_user.id, r_user.nickname, r_user.email, r_user.image)
    else
      nil
    end
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
    friends = Friendship.where("user_id = #{self.id} or friend_id = #{self.id} and status = 1")
    lst = Array.new
    lst = friends.select("friend_id as id").where(user_id: self.id, status: 1)
    lst += friends.select("user_id as id").where(friend_id: self.id, status: 1)
    users = User.where(id: lst)
  end

  def finishied_goals
    UserGoal.where(user_id: self.id, state: "2")
  end

  def edit_user(user, profile, _params)
    profile.attributes = _params.reject{|k,v| !profile.attributes.keys.member?(k.to_s)}
    user.attributes = _params.reject{|k,v| !user.attributes.keys.member?(k.to_s)}
    if !user.save
      errors.add(:user, "problem when the system try to save the user")
    end
    if !profile.save
      errors.add(:profile, "problem when the system try to save the profile")
    end
  end

  protected
    def create_lvl
      UserLevel.create(level_id: 1, user_id: self.id,points: 0)
    end
end

class Random
  @@no_of_randoms = 0
  def initialize(goal_id, user_id, nickname, email, image)
    @goal_id = goal_id
    @user_id = user_id
    @nickname = nickname
    @email = email
    @image = image.present? ? image : nil
  end
end