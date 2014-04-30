class GoalCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :image

  def image
    if object.image_url.present?
      "http://zircle.herokuapp.com#{object.image_url.to_s}"
    end
  end
end
