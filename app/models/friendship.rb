class Friendship < ActiveRecord::Base
  validates :user_id, :friend_id, :status, presence: true
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

end
