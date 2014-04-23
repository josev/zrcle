class UserStepSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status
  has_one :goal_step
end
