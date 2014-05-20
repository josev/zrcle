class FollowUser < ActiveRecord::Base
  validates :user_id, :follow_user_id, presence: true
  belongs_to :user
  belongs_to :user, :foreign_key => "follow_user_id"
  alias_attribute :follow_user, :user

  def self.get_follow_users(_params)
    if _params[:user_id].present?
      FollowUser.where(user_id: _params[:user_id])
    elsif _params[:follow_user_id]
      FollowUser.where(follow_user_id: _params[:follow_user_id])
    else
      FollowUser.all
    end
  end

  def self.follows(user)
     fwls = FollowUser.select("follow_user_id as id").where(user_id: user.id, status: 1)
    User.where(id: fwls)
  end

  def self.follow_me(user)
    flws = FollowUser.select("user_id as id").where(follow_user_id: user.id, status: 1)
    User.where(id: flws)
  end
end
