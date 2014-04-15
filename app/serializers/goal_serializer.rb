class GoalSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :goal_category_id, :expected_result, :goal_type_id, 
   :users

  def users
    UserGoal.where(goal_id: object.id).count
  end
end
