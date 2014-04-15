class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email, :password, :provider, :uid, :oauth_token, :image,
  :country, :description, :follows, :friends, :finishied_goals, :goals

  #has_one :profile

  def country
  	if object.profile.present?
  		object.profile.country
  	else
  		nil
  	end
  end

  def description
  	if object.profile.present?
  		object.profile.description
  	else
  		nil
  	end
  end

  def follows
  	object.following_me.count
  end

  def friends
  	object.friends.count
  end

  def finishied_goals
  	object.goals.count
  end

  def goals
  	object.goals.count
  end
end
