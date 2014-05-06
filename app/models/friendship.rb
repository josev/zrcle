class Friendship < ActiveRecord::Base
  validates :user_id, :friend_id, :status, presence: true
  before_create :exist
  belongs_to :user
  belongs_to :user, :foreign_key => "friend_id"
  alias_attribute :friend, :user

  def self.get_friendships(_params)
    if _params[:user_id].present?
      Friendship.where(user_id: _params[:user_id])
    elsif _params[:friend_id].present?
      Friendship.where(friend_id: _params[:friend_id])
    elsif _params[:friendship_id]
      Friendship.find_by_id(_params[:friendship_id])
    else
      Friendship.all
    end
  end

  def self.get_friends(user_id)
    friends = Friendship.where("user_id = #{user_id} or friend_id = #{user_id}")
    lst = Array.new
    lst = friends.select("friend_id as id").where(user_id: user_id)
    lst += friends.select("user_id as id").where(friend_id: user_id)
    users = User.where(id: lst)
  end

  def self.get_friends_by_name(user_id,text)
    friends = Friendship.where("user_id = #{user_id} or friend_id = #{user_id}")
    lst = Array.new
    lst = friends.select("friend_id as id").where(user_id: user_id)
    lst += friends.select("user_id as id").where(friend_id: user_id)
    users = User.where(id: lst).where("name like '%#{text}%'")
  end

  def self.get_friends_by_goal(user, goal_id)
    f_goal = UserGoal.where(user_id: user.friends, goal_id: goal_id)
    friends = Array.new
    f_goal.each do |ug|
      friends.push(ug.user_id)
    end
    User.where(id: friends)
  end

  protected
    def exist
      request = Friendship.where(user_id: self.user_id, friend_id: self.friend_id).first
      if request.present?
        if request.status == 2
          errors.add(:friend_request, 'you already sent this friend request')
        else
          errors.add(:friend_request, 'this user is already your friend')
        end
      end
      request = Friendship.where(user_id: self.friend_id, friend_id: self.user_id).first
      if request.present?
        if request.status == 2
          errors.add(:friend_request, 'you have this friend request, only need confirm')
        else
          errors.add(:friend_request, 'this user is already your friend')
        end
      end 
    end

end
