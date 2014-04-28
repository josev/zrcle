class UserStepSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status
  :goal_step
  has_one :goal_step
end
