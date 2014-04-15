class GoalSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :goal_category_id, :expected_result, :goal_type_id, 
  :follows, :users

  def follows
    FollowGoal.where(follow_goal_id: object.id).count
  end

  def users
    UserGoal.where(goal_id: object.id).count
  end
end
