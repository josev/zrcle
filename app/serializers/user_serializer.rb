class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email, :password, :provider, :uid, :oauth_token, :image,
  :country, :description, :follows, :friends, :finishied_goals, :goals, :goals_ids, :lvl, :points, :required_points

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
  	object.finishied_goals.count
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

  def lvl
    object.level.present? ? object.level.level_number : 0
  end

  def points
    object.user_level.present? ? object.user_level.points : 0
  end

  def required_points
    object.level.present? ? object.level.required_points : 0
  end
end
