class CommentSerializer < ActiveModel::Serializer
  attributes :id, :goal_id, :user_id, :to_user_id, :comment, :created_at, :nickname, :image

  def nickname
    object.user.nickname
  end

  def image
    "http://zircle.herokuapp.com#{object.user.image_url}"
  end
end
