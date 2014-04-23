class GoalSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :goal_category_id, :expected_result, :goal_type_id, 
  :users, :friends, :progress, :current_step

  #has_many :users, through: :user_goals

  def users
  	object.users.count
  end

  def include_friends?
    friends
  end
  def friends
    u = User.find_by_id(options[:user_id])
    if u.present?
      UserGoal.where(goal_id: object.id, user_id: u.friends).count
    else
      nil
    end
  end

  def include_progress?
    progress
  end
  def progress
    u = User.find_by_id(options[:user_id])
    if u.present?
      if object.steps.present? && object.completes(u.id).present?
        object.completes.count/object.steps.count
      else
        0
      end
    else
      nil
    end
  end

  def include_current_step?
    current_step
  end
  def current_step
    u = User.find_by_id(options[:user_id])
    if u.present?
      object.current_step(u.id).order
    else
      nil
    end
  end
end
