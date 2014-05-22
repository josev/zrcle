class UserStepSerializer < ActiveModel::Serializer
  attributes :user_step_id, :id, :title, :order, :description, :status, :updated_at
  #:goal_step
  #has_one :goal_step
  def user_step_id
    object.id
  end

  def id
    object.goal_step.id
  end

  def title
    object.goal_step.title
  end

  def order
    object.goal_step.order
  end

  def description
    object.goal_step.description
  end

  def status
    object.status
  end

  def updated_at
    object.updated_at
  end
end
