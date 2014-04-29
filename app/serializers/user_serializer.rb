class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email, :password, :provider, :uid, :oauth_token, :image,
  :country, :description, :follows, :friends, :finishied_goals, :goals, :goals_ids

  #has_many :goals, through: :user_goals

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

  def goals_ids
    id = Array.new
    object.goals.each do |g|
      if g.goal.present?
        id.push(g.goal.id)
      end
    end
    id
  end

  def image
    if object.image_url.present?
      "http://zircle.herokuapp.com#{object.image_url.to_s}"
    else
      nil
    end
  end
end
