class GoalStepSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :goal_id, :order
end
