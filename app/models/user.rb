class User < ActiveRecord::Base
  has_many :user_goals

  has_many :friendships
  has_many :_friends, through: :friendships, foreign_key: "friend_id"
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates_uniqueness_of :email, :uid

  def goals
    UserGoal.where(user_id: self.id)
  end

  def friends
    self._friends + self.inverse_friends
  end
end
